class InhouseGroup < ActiveRecord::Base
  belongs_to :email_message
  has_many :inhouse_customers, -> { order "id DESC"}
end
