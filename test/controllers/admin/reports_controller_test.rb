require 'test_helper'

class Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post :create, report: { amount_of_purchases: @report.amount_of_purchases, amount_of_quotes: @report.amount_of_quotes, catalogs_ordered: @report.catalogs_ordered, month: @report.month, new_users: @report.new_users, number_of_orders: @report.number_of_orders, number_of_purchases: @report.number_of_purchases, number_of_quotes: @report.number_of_quotes, year: @report.year }
    end

    assert_redirected_to admin_report_path(assigns(:report))
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report
    assert_response :success
  end

  test "should update report" do
    patch :update, id: @report, report: { amount_of_purchases: @report.amount_of_purchases, amount_of_quotes: @report.amount_of_quotes, catalogs_ordered: @report.catalogs_ordered, month: @report.month, new_users: @report.new_users, number_of_orders: @report.number_of_orders, number_of_purchases: @report.number_of_purchases, number_of_quotes: @report.number_of_quotes, year: @report.year }
    assert_redirected_to admin_report_path(assigns(:report))
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_redirected_to admin_reports_path
  end
end
