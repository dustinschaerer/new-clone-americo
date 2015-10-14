require 'test_helper'

class Admin::InhouseGroupsControllerTest < ActionController::TestCase
  setup do
    @inhouse_group = inhouse_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inhouse_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inhouse_group" do
    assert_difference('InhouseGroup.count') do
      post :create, inhouse_group: { email_message_id: @inhouse_group.email_message_id, last_sent_on: @inhouse_group.last_sent_on, name: @inhouse_group.name }
    end

    assert_redirected_to admin_inhouse_group_path(assigns(:inhouse_group))
  end

  test "should show inhouse_group" do
    get :show, id: @inhouse_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inhouse_group
    assert_response :success
  end

  test "should update inhouse_group" do
    patch :update, id: @inhouse_group, inhouse_group: { email_message_id: @inhouse_group.email_message_id, last_sent_on: @inhouse_group.last_sent_on, name: @inhouse_group.name }
    assert_redirected_to admin_inhouse_group_path(assigns(:inhouse_group))
  end

  test "should destroy inhouse_group" do
    assert_difference('InhouseGroup.count', -1) do
      delete :destroy, id: @inhouse_group
    end

    assert_redirected_to admin_inhouse_groups_path
  end
end
