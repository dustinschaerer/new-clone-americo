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

  # scope use: User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
  #scope :created_between, ->(start_date, end_date) { where("created_at >= ? AND created_at <= ?", start_date, end_date) }

  # User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
  # start_date = Time.zone.now.beginning_of_month.beginning_of_day
  # end_date = Time.zone.now.end_of_month.end_of_day
  def self.created_between(start_date, end_date)
    where("created_at >= ? AND created_at <= ?", start_date, end_date)
  end



end
