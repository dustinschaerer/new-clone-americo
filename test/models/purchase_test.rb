require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should validate_presence_of(:firstname)
  should validate_presence_of(:lastname)
  should validate_presence_of(:telephone)
  should validate_presence_of(:contactby)
  should validate_presence_of(:ship_street_address)
  should validate_presence_of(:ship_city)
  should validate_presence_of(:ship_state)
  should validate_presence_of(:ship_zipcode)
  should validate_presence_of(:ship_country)
  should validate_presence_of(:pay_firstname)
  should validate_presence_of(:pay_lastname)
  should validate_presence_of(:pay_telephone)
  should validate_presence_of(:pay_street_address)
  should validate_presence_of(:pay_city)
  should validate_presence_of(:pay_state)
  should validate_presence_of(:pay_zipcode)
  should validate_presence_of(:pay_country)
  should validate_presence_of(:pay_type)
  should validate_presence_of(:pay_status)
  should validate_presence_of(:status)

end
