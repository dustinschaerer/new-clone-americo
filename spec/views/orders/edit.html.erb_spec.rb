require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :name => "MyString",
      :ship_street_address => "MyString",
      :ship_city => "MyString",
      :ship_state => "MyString",
      :ship_country => "MyString",
      :telephone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_name[name=?]", "order[name]"
      assert_select "input#order_ship_street_address[name=?]", "order[ship_street_address]"
      assert_select "input#order_ship_city[name=?]", "order[ship_city]"
      assert_select "input#order_ship_state[name=?]", "order[ship_state]"
      assert_select "input#order_ship_country[name=?]", "order[ship_country]"
      assert_select "input#order_telephone[name=?]", "order[telephone]"
      assert_select "input#order_email[name=?]", "order[email]"
    end
  end
end
