require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :name => "Name",
        :ship_street_address => "Ship Street Address",
        :ship_city => "Ship City",
        :ship_state => "Ship State",
        :ship_country => "Ship Country",
        :telephone => "Telephone",
        :email => "Email"
      ),
      stub_model(Order,
        :name => "Name",
        :ship_street_address => "Ship Street Address",
        :ship_city => "Ship City",
        :ship_state => "Ship State",
        :ship_country => "Ship Country",
        :telephone => "Telephone",
        :email => "Email"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ship Street Address".to_s, :count => 2
    assert_select "tr>td", :text => "Ship City".to_s, :count => 2
    assert_select "tr>td", :text => "Ship State".to_s, :count => 2
    assert_select "tr>td", :text => "Ship Country".to_s, :count => 2
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
