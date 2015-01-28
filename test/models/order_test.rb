#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  should validate_presence_of(:firstname)
  should validate_presence_of(:lastname)
  should validate_presence_of(:street_address)
  should validate_presence_of(:city)
  should validate_presence_of(:state)
  should validate_presence_of(:zipcode)
  should validate_presence_of(:country)
  should validate_presence_of(:status)
  should validate_presence_of(:email)

  test "order attributes must not be empty" do
    order = Order.new
    assert order.invalid?, "Invalid order"
    assert order.errors[:firstname].any?, "No firstname"
    assert order.errors[:lastname].any?, "No lastname"
    assert order.errors[:street_address].any?, "No street address"
    assert order.errors[:city].any?, "No city"
    assert order.errors[:state].any?, "No state"
    assert order.errors[:country].any?, "No country"
    assert order.errors[:email].any?, "No email"
    assert order.errors[:zipcode].any?, "No zipcode"
  end

  test "order must contain all necessary attributes to be valid" do
    order = Order.new(firstname: "Tim",
                      lastname: "Smith",
                      street_address: "123 Way Street",
                      city: "Portland",
                      state: "Oregon",
                      country: "United States",
                      zipcode: "95555",
                      email: users(:tim).email,
                      user_id: users(:tim).id,
                      status: "Submitted" )
    assert order.valid?, "Order should be valid with all attributes"
  end


  #  test "image url is valid with correct URL" do
  #    order = Order.new(title:       "Vinyl Swatch Sample",
  #                          description: "8 x 10 Vinyl Swatch Sample",
  #                          category:    "Vinyl",
  #                          image_url:   "fred.gif",
  #                          thumbnail_url: "fred-thumb.gif" )
  #
  #   assert order.valid?, "fred.gif should be valid"
  #  end

  # test "the truth" do
  #   assert true
  # end
end
