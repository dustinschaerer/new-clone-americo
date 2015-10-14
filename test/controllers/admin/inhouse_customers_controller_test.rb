require 'test_helper'

class Admin::InhouseCustomersControllerTest < ActionController::TestCase
  setup do
    @inhouse_customer = inhouse_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inhouse_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inhouse_customer" do
    assert_difference('InhouseCustomer.count') do
      post :create, inhouse_customer: { date: @inhouse_customer.date, email: @inhouse_customer.email, is_user: @inhouse_customer.is_user, name: @inhouse_customer.name }
    end

    assert_redirected_to admin_inhouse_customer_path(assigns(:inhouse_customer))
  end

  test "should show inhouse_customer" do
    get :show, id: @inhouse_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inhouse_customer
    assert_response :success
  end

  test "should update inhouse_customer" do
    patch :update, id: @inhouse_customer, inhouse_customer: { date: @inhouse_customer.date, email: @inhouse_customer.email, is_user: @inhouse_customer.is_user, name: @inhouse_customer.name }
    assert_redirected_to admin_inhouse_customer_path(assigns(:inhouse_customer))
  end

  test "should destroy inhouse_customer" do
    assert_difference('InhouseCustomer.count', -1) do
      delete :destroy, id: @inhouse_customer
    end

    assert_redirected_to admin_inhouse_customers_path
  end
end
