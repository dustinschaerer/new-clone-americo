class SentEmail < ActiveRecord::Base
  belongs_to :email_message
  belongs_to :sendable, polymorphic: true
  belongs_to :user, -> { where( sent_emails: {sendable_type: 'User'})}
  belongs_to :prospect, -> { where( sent_emails: {sendable_type: 'Prospect'})}

  serialize :actual_recipients


  def user_email
    if sendable_id.nil?
      @user_email
     end
  end

  def user_email=(val)
    @user_email = val
  end

  def prospect_email
    if sendable_id.nil?
      @prospect_email
     end
  end

  def prospect_email=(val)
    @prospect_email = val
  end

  # def sendable_name
  #   sendable.try(:name) if sendable
  # end

  # def sendable_name=(name)
  #   self.sendable = Sendable.find_by_name(name) if name.present?
  # end

end
