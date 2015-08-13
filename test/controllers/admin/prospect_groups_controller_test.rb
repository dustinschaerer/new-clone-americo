require 'test_helper'

class Admin::ProspectGroupsControllerTest < ActionController::TestCase
  setup do
    @admin_prospect_group = admin_prospect_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_prospect_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_prospect_group" do
    assert_difference('Admin::ProspectGroup.count') do
      post :create, admin_prospect_group: { name: @admin_prospect_group.name }
    end

    assert_redirected_to admin_prospect_group_path(assigns(:admin_prospect_group))
  end

  test "should show admin_prospect_group" do
    get :show, id: @admin_prospect_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_prospect_group
    assert_response :success
  end

  test "should update admin_prospect_group" do
    patch :update, id: @admin_prospect_group, admin_prospect_group: { name: @admin_prospect_group.name }
    assert_redirected_to admin_prospect_group_path(assigns(:admin_prospect_group))
  end

  test "should destroy admin_prospect_group" do
    assert_difference('Admin::ProspectGroup.count', -1) do
      delete :destroy, id: @admin_prospect_group
    end

    assert_redirected_to admin_prospect_groups_path
  end
end
