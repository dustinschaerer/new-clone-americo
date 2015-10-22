class Prospect < ActiveRecord::Base

  validates :email, :email_format => { :message => "Invalid email address, try again!", :check_mx => true }

  belongs_to :prospect_group
  belongs_to :email_message

  def status
    self.subscribed ? 'Subscribed' : 'Unsubscribed'
  end

end