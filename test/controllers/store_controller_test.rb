require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'h3', 'Vinyl Swatch Sample'
  end

  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select 'h1', /Store/
    assert_select '.entry input[type=submit]', 3
  end

end