require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:order_one)
    sign_in users(:user_one)
  end

  test "requires item in cart" do
    get :new
    assert_equal flash[:notice], 'Your cart is empty, you must select a sample swatch to proceed to checkout.'
  end

  test "should get new" do
    item = LineItem.new
    item.build_cart
    item.series = series(:series_one)
    item.color = colors(:two)
    item.save!
    session[:cart_id] = item.cart.id
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { firstname: @order.firstname,
                             lastname: @order.lastname,
                             email: @order.email,
                             street_address: @order.street_address,
                             city: @order.city,
                             state: @order.state,
                             country: @order.country,
                             zipcode: @order.zipcode,
                             telephone: @order.telephone,
                             status: @order.status,
                             user_id: @order.user_id,
                             company: @order.company}
    end
    assert_redirected_to 'order_submitted')
  end

  test "show order to signed in user that owns it" do
    get :show, id: @order
    assert_response :success
  end

  test "do not show order to signed in user that does not belong to them" do
    @order_three = orders(:order_three)
    get :show, id: @order_three
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal "The order you tried to access does not belong to you.", flash[:notice]
  end

  test "should redirect to admin on get index" do
    get :index
    assert_response :redirect
    assert_redirected_to new_admin_user_session_path
    assert_nil assigns(:orders)
  end

  test "should get order edit if this order belongs to signed in user" do
    get :edit, id: @order
    assert_response :success
  end

  test "should not get order edit if this order belongs to signed in user" do
    @order_three = orders(:order_three)
    get :edit, id: @order_three
    assert_response :redirect
    assert_redirected_to root_url
    assert_equal "The order you tried to edit does not belong to you.", flash[:notice]
  end

=begin
  test "should update order" do
    patch :update, id: @order, order: { name: @order.name,
                             email: @order.email,
                             street_address: @order.street_address,
                             city: @order.city,
                             state: @order.state,
                             country: @order.country,
                             telephone: @order.telephone }
    assert_redirected_to order_path(assigns(:order))
  end
=end

  test "should not allow for destroying order" do
    assert_no_difference('Order.count') do
      delete :destroy, id: @order
    end
    assert_response :redirect
    assert_redirected_to new_admin_user_session_path
  end

end
