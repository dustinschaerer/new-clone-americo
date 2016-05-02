require 'test_helper'

class QuotesControllerTest < ActionController::TestCase

  setup do
    @quote_three = quotes(:three)
    sign_in users(:user_one)
  end

  test "requires line in quoteholder" do
    get :new
    assert_equal flash[:notice], 'Please add items to your Quote before submitting it.'
  end

  test "should redirect to admin on get index" do
    get :index
    assert_response :redirect
    assert_redirected_to new_admin_user_session_path
    assert_nil assigns(:quotes)
  end

  test "should get new" do
    line = Line.new
    line.build_quoteholder
    line.quote_product = quote_products(:one)
    line.shape = shapes(:round)
    line.cover = covers(:regular)
    line.width = '48'
    line.series = series(:series_one)
    line.color = colors(:two)
    line.umbrella = 0
    line.velcro = 0
    line.quantity = 5
    line.price = 0
    line.save!
    session[:quoteholder_id] = line.quoteholder.id
    get :new
    assert_response :success
  end

  test "should create quote" do
    assert_difference('Quote.count') do
      post :create, quote: {
        user_id: @quote_three.user_id,
        email: @quote_three.email,
        contactby: @quote_three.contactby,
        firstname: @quote_three.firstname,
        lastname: @quote_three.lastname,
        telephone: @quote_three.telephone,
        pay_type: @quote_three.pay_type,
        ship_street_address: @quote_three.ship_street_address,
        ship_city: @quote_three.ship_city,
        ship_state: @quote_three.ship_state,
        ship_country: @quote_three.ship_country,
        ship_zipcode: @quote_three.ship_zipcode,
        subtotal: @quote_three.subtotal,
        shipping: @quote_three.shipping,
        sales_tax: @quote_three.sales_tax,
        total: @quote_three.total }
    end
    # assert_redirected_to user_path(users(:user_one))
    assert_redirected_to '/quote_requested'
    assert_equal 10, Quote.all.count
  end

  test "show quote to signed in user that owns it" do
    sign_out users(:user_one)
    sign_in users(:tim)
    get :show, id: @quote_three
    assert_response :success
  end

  test "do not show quote to signed in user that does not belong to them" do
    get :show, id: @quote_three
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal "The quote you tried to access does not belong to you.", flash[:notice]
  end

  test "should get edit" do
    sign_out users(:user_one)
    sign_in users(:tim)
    get :edit, id: @quote_three
    assert_response :success
  end

  test "should not allow for destroying a quote" do
    assert_no_difference('Quote.count') do
      delete :destroy, id: @quote_three
    end
    assert_response :redirect
    assert_redirected_to new_admin_user_session_path
  end

=begin
  test "should update quote" do
    patch :update, id: @quote, quote: { contactby: @quote.contactby, firstname: @quote.firstname, lastname: @quote.lastname, pay_type: @quote.pay_type, sales_tax: @quote.sales_tax, ship_city: @quote.ship_city, ship_country: @quote.ship_country, ship_state: @quote.ship_state, ship_street_address: @quote.ship_street_address, ship_zipcode: @quote.ship_zipcode, shipping: @quote.shipping, subtotal: @quote.subtotal, telephone: @quote.telephone, total: @quote.total, user_id: @quote.user_id }
    assert_redirected_to quote_path(assigns(:quote))
  end
=end

end
