class EmailMessage < ActiveRecord::Base

  validates_presence_of :subject, :content
  has_many :prospect_groups

end
