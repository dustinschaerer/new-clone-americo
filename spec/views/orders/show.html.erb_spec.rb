require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :name => "Name",
      :ship_street_address => "Ship Street Address",
      :ship_city => "Ship City",
      :ship_state => "Ship State",
      :ship_country => "Ship Country",
      :telephone => "Telephone",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Ship Street Address/)
    rendered.should match(/Ship City/)
    rendered.should match(/Ship State/)
    rendered.should match(/Ship Country/)
    rendered.should match(/Telephone/)
    rendered.should match(/Email/)
  end
end
