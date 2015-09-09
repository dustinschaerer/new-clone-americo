require 'test_helper'

class Admin::MandrilTagsControllerTest < ActionController::TestCase
  setup do
    @mandril_tag = mandril_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mandril_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mandril_tag" do
    assert_difference('MandrilTag.count') do
      post :create, mandril_tag: { title: @mandril_tag.title }
    end

    assert_redirected_to admin_mandril_tag_path(assigns(:mandril_tag))
  end

  test "should show mandril_tag" do
    get :show, id: @mandril_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mandril_tag
    assert_response :success
  end

  test "should update mandril_tag" do
    patch :update, id: @mandril_tag, mandril_tag: { title: @mandril_tag.title }
    assert_redirected_to admin_mandril_tag_path(assigns(:mandril_tag))
  end

  test "should destroy mandril_tag" do
    assert_difference('MandrilTag.count', -1) do
      delete :destroy, id: @mandril_tag
    end

    assert_redirected_to admin_mandril_tags_path
  end
end
