require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase

  setup do
    @purchase = purchases(:one)
  end

  test "should get new for signed in user with priced quote" do
    sign_in users(:user_one)
    @quote = quotes(:quote_one)
    get(:new, {'quote_id' => "#{@quote.id}"})
    assert_response :success
  end

  test "should not get new for signed in user with submitted quote status" do
    sign_in users(:tim)
    @quote = quotes(:two)
    get(:new, {'quote_id' => "#{@quote.id}"})
    assert_response :redirect
  end

  test "should not get new for unsigned in user with priced quote status" do
    @quote = quotes(:quote_one)
    get(:new, {'quote_id' => "#{@quote.id}"})
    assert_response :redirect
  end

  test "should not get new for unsigned in user with submitted quote status" do
    @quote = quotes(:quote_one)
    get(:new, {'quote_id' => "#{@quote.id}"})
    assert_response :redirect
  end

  test "show purchase to signed in user that owns it" do
    sign_in users(:user_one)
    get :show, id: @purchase
    assert_response :success
  end

  test "should not show purchase to unsigned in user" do
    get :show, id: @purchase
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "do not show purchase to signed in user that does not belong to them" do
    sign_in users(:user_one)
    @purchase_two = purchases(:two)
    get :show, id: @purchase_two
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal "The purchase you tried to access does not belong to you.", flash[:notice]
  end

=begin
  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { contactby: @purchase.contactby, firstname: @purchase.firstname, lastname: @purchase.lastname, pay_city: @purchase.pay_city, pay_country: @purchase.pay_country, pay_state: @purchase.pay_state, pay_street_address: @purchase.pay_street_address, pay_type: @purchase.pay_type, pay_zipcode: @purchase.pay_zipcode, sales_tax: @purchase.sales_tax, ship_city: @purchase.ship_city, ship_country: @purchase.ship_country, ship_state: @purchase.ship_state, ship_street_address: @purchase.ship_street_address, ship_zipcode: @purchase.ship_zipcode, shipping: @purchase.shipping, subtotal: @purchase.subtotal, telephone: @purchase.telephone, total: @purchase.total, user_id: @purchase.user_id }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should update purchase" do
    patch :update, id: @purchase, purchase: { contactby: @purchase.contactby, firstname: @purchase.firstname, lastname: @purchase.lastname, pay_city: @purchase.pay_city, pay_country: @purchase.pay_country, pay_state: @purchase.pay_state, pay_street_address: @purchase.pay_street_address, pay_type: @purchase.pay_type, pay_zipcode: @purchase.pay_zipcode, sales_tax: @purchase.sales_tax, ship_city: @purchase.ship_city, ship_country: @purchase.ship_country, ship_state: @purchase.ship_state, ship_street_address: @purchase.ship_street_address, ship_zipcode: @purchase.ship_zipcode, shipping: @purchase.shipping, subtotal: @purchase.subtotal, telephone: @purchase.telephone, total: @purchase.total, user_id: @purchase.user_id }
    assert_redirected_to purchase_path(assigns(:purchase))
  end
=end

=begin

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
=end

end
