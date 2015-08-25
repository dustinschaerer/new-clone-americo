class SentEmail < ActiveRecord::Base
  belongs_to :email_message
  belongs_to :sendable, polymorphic: true

end
