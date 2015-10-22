class InhouseCustomer < ActiveRecord::Base

  validates_presence_of :email, :name, :date
  validates_uniqueness_of :email
  belongs_to :inhouse_group

end
