class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :quotes
  has_many :purchases
  has_many :subscribers
  belongs_to :user_group
  has_many :sent_emails, as: :sendable
  belongs_to :email_message

  after_create :process_if_prospect

  def self.created_between(start_date, end_date)
    where("created_at >= ? AND created_at <= ?", start_date, end_date)
  end

  def process_if_prospect
    # if created user is a prospect, set date joined on field and mark user inactive
    prospect = Prospect.find_by_email(self.email)
    if prospect.present?
      prospect.date_joined_on = self.created_at
      prospect.active = false
      prospect.save!
    end
  end

  def status
    self.subscribed ? 'Subscribed' : 'Unsubscribed'
  end

end