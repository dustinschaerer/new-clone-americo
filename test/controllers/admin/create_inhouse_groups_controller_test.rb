require 'test_helper'

class Admin::CreateInhouseGroupsControllerTest < ActionController::TestCase
  setup do
    @create_inhouse_group = create_inhouse_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_inhouse_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_inhouse_group" do
    assert_difference('CreateInhouseGroup.count') do
      post :create, create_inhouse_group: { email_message_id: @create_inhouse_group.email_message_id, last_sent_on: @create_inhouse_group.last_sent_on, name: @create_inhouse_group.name }
    end

    assert_redirected_to admin_create_inhouse_group_path(assigns(:create_inhouse_group))
  end

  test "should show create_inhouse_group" do
    get :show, id: @create_inhouse_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_inhouse_group
    assert_response :success
  end

  test "should update create_inhouse_group" do
    patch :update, id: @create_inhouse_group, create_inhouse_group: { email_message_id: @create_inhouse_group.email_message_id, last_sent_on: @create_inhouse_group.last_sent_on, name: @create_inhouse_group.name }
    assert_redirected_to admin_create_inhouse_group_path(assigns(:create_inhouse_group))
  end

  test "should destroy create_inhouse_group" do
    assert_difference('CreateInhouseGroup.count', -1) do
      delete :destroy, id: @create_inhouse_group
    end

    assert_redirected_to admin_create_inhouse_groups_path
  end
end
