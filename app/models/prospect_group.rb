class ProspectGroup < ActiveRecord::Base
  belongs_to :email_message
  has_many :prospects, -> { order "id DESC"}
end
