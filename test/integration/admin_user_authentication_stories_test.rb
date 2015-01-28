require 'test_helper'

class AdminUserAuthenticationStoriesTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = FactoryGirl.create(:admin_user)
  end

  test "should allow a registered admin user to sign in" do
    visit root_url
    visit '/admin_users/sign_in'
    assert_equal "/admin_users/sign_in", current_path
    assert_equal new_admin_user_session_path, current_path
    fill_in "Email", :with => @admin_user.email
    fill_in "Password", :with => @admin_user.password
    click_button "Sign in"
    assert has_selector? "a", text: "Administration Area Home"
    assert has_selector? "a", text: "Dashboard"
    assert has_selector? "a", text: "Orders"
    assert has_selector? "a", text: "Quotes"
    assert has_selector? "a", text: "Purchases"
    click_link "Orders"
    assert has_selector? "h1", text: "Orders"
    click_link "Quotes"
    assert has_selector? "h1", text: "Quotes"
    click_link "Purchases"
    assert has_selector? "h1", text: "Purchases"
    assert_equal "/admin/purchases/", current_path, "Current Path is #{current_path}"
  end

  test "should not allow a user to sign up as admin user" do
    visit root_url
    assert_raise(ActionController::RoutingError) {
      get '/admin_users/sign_up'
    }
  end

  test "should not allow a registered admin user to sign in with wrong email" do
    visit root_url
    visit '/admin_users/sign_in'
    assert_equal "/admin_users/sign_in", current_path
    assert_equal new_admin_user_session_path, current_path
    fill_in "Email", :with => "wrong_admin_name@example.com"
    fill_in "Password", :with => @admin_user.password
    click_button "Sign in"
    assert has_selector? "h1", text: "Administrator Sign in"
    assert_equal "/admin_users/sign_in", current_path
  end

  test "should not allow a registered admin user to sign in with wrong password" do
    visit root_url
    visit '/admin_users/sign_in'
    assert_equal "/admin_users/sign_in", current_path
    assert_equal new_admin_user_session_path, current_path
    fill_in "Email", :with => @admin_user.email
    fill_in "Password", :with => "wrongpassword"
    click_button "Sign in"
    assert has_selector? "h1", text: "Administrator Sign in"
    assert_equal "/admin_users/sign_in", current_path
  end

  test "should not allow a user to sign in with wrong user and password" do
    visit root_url
    visit '/admin_users/sign_in'
    assert_equal "/admin_users/sign_in", current_path
    assert_equal new_admin_user_session_path, current_path
    fill_in "Email", :with => "wrong_admin_name@example.com"
    fill_in "Password", :with => "wrongpassword"
    click_button "Sign in"
    assert has_selector? "h1", text: "Administrator Sign in"
    assert_equal "/admin_users/sign_in", current_path
  end

end