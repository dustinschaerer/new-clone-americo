class UserGroup < ActiveRecord::Base
  belongs_to :email_message
  has_many :users
  has_many :sent_emails, as: :sendable
end
