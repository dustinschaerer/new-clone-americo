class EmailMessage < ActiveRecord::Base

  validates_presence_of :subject, :content
  has_many :prospect_groups
  has_many :user_groups
  has_many :sent_emails, as: :sendable
end
