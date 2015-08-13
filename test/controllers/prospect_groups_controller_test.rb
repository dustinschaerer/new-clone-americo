require 'test_helper'

class ProspectGroupsControllerTest < ActionController::TestCase
  setup do
    @prospect_group = prospect_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prospect_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prospect_group" do
    assert_difference('ProspectGroup.count') do
      post :create, prospect_group: { email_message_id: @prospect_group.email_message_id, last_sent_on: @prospect_group.last_sent_on, name: @prospect_group.name }
    end

    assert_redirected_to prospect_group_path(assigns(:prospect_group))
  end

  test "should show prospect_group" do
    get :show, id: @prospect_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prospect_group
    assert_response :success
  end

  test "should update prospect_group" do
    patch :update, id: @prospect_group, prospect_group: { email_message_id: @prospect_group.email_message_id, last_sent_on: @prospect_group.last_sent_on, name: @prospect_group.name }
    assert_redirected_to prospect_group_path(assigns(:prospect_group))
  end

  test "should destroy prospect_group" do
    assert_difference('ProspectGroup.count', -1) do
      delete :destroy, id: @prospect_group
    end

    assert_redirected_to prospect_groups_path
  end
end
