require 'test_helper'

class StylesControllerTest < ActionController::TestCase

  setup do
    @style = styles(:style_one)
  end

  test "should show style" do
    get :show, id: @style
    assert_response :success
  end

  test "should redirect to admin on get index" do
    get :index
    assert_redirected_to new_admin_user_session_path
  end

  test "should redirect to admin on get new" do
    get :new
    assert_redirected_to new_admin_user_session_path
  end

  test "should redirect to admin on create style" do
    assert_no_difference('Style.count') do
      post :create, style: { description: @style.description, image_url: @style.image_url, name: @style.name, title: @style.title }
    end
    assert_redirected_to new_admin_user_session_path
  end

  test "should redirect to admin on get edit" do
    get :edit, id: @style
    assert_redirected_to new_admin_user_session_path
  end

  test "should redirect to admin on update style" do
    patch :update, id: @style, style: { description: @style.description, image_url: @style.image_url, name: @style.name, title: @style.title }
    assert_redirected_to new_admin_user_session_path
  end

  test "should redirect to admin on destroy style" do
    assert_no_difference('Style.count') do
      delete :destroy, id: @style
    end
    assert_redirected_to new_admin_user_session_path
  end

end
