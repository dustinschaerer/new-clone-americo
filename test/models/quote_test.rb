require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  should validate_presence_of(:firstname)
  should validate_presence_of(:lastname)
  should validate_presence_of(:telephone)
  should validate_presence_of(:contactby)
  should validate_presence_of(:ship_street_address)
  should validate_presence_of(:ship_city)
  should validate_presence_of(:ship_state)
  should validate_presence_of(:ship_zipcode)
  should validate_presence_of(:ship_country)
  should validate_presence_of(:subtotal)
  should validate_presence_of(:shipping)
  should validate_presence_of(:sales_tax)
  should validate_presence_of(:total)

  test "knows if it is completed/priced" do
    @quote_one = quotes(:quote_one)
    @quote_two = quotes(:two)
    assert_equal @quote_one.is_complete?, true, "Quote one should be completed"
    assert_equal @quote_two.is_complete?, false, "Quote two should not be completed"
  end

  test "knows its current color" do
    @quote_one = quotes(:quote_one)
    @quote_two = quotes(:two)
    @quote_four = quotes(:four)
    @quote_five = quotes(:five)
    assert_equal @quote_one.current_color, :ok, "Quote one should return :warn symbol"
    assert_equal @quote_two.current_color, :warn, "Quote two should return ok symbol"
    assert_equal @quote_four.current_color, :offline_purchased, "Quote four should return offline purchased symbol"
    assert_equal @quote_five.current_color, :error, "Quote five should return error symbol"
  end



  test "it knows its total price" do
    skip("Models Quote Test - it knows its total price")
    quote_two = quotes(:two)
    line3 = lines(:three)
    line4 = lines(:four)
    assert_equal quote_two.total_price, 44.00, quote_two.total_price
  end


  test "knows how to calculate its subtotal" do
    skip("Models Quote Test - knows how to calculate its subtotal")
    quote_two = quotes(:two)
    line3 = lines(:three)
    line4 = lines(:four)
    assert_equal quote_two.subtotal, 0, quote_two.subtotal
    assert_equal line3.quantity, 3, line3.quantity
    assert_equal line3.price, 8.00, line3.price
    assert_equal line4.quantity, 2, line4.quantity
    assert_equal line4.price, 10.00, line4.price
    quote_two.calculate_subtotal
    assert_equal quote_two.subtotal.to_f, 44.00, "Current subtotal value is #{quote_two.subtotal}"
  end

  test "knows how to calculate sales tax in Arkansas" do
    quote_eight = quotes(:eight)
    assert_equal quote_eight.calculate_sales_tax.to_f, 10.75
  end

  test "knows how to calculate sales tax in New Jersey" do
    quote_six = quotes(:six)
    assert_equal quote_six.calculate_sales_tax.to_f, 7.00
  end

  test "knows how to calculate sales tax in Minnesota" do
    @quote_seven = quotes(:seven)
    assert_equal @quote_seven.calculate_sales_tax.to_f, 6.87
  end



end
