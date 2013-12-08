require 'spec_helper'

describe "products/new" do
  before(:each) do
    assign(:product, stub_model(Product,
      :title => "MyString",
      :description => "MyText",
      :category => "MyString",
      :image_url => "MyString",
      :thumbnail_url => "MyString"
    ).as_new_record)
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", products_path, "post" do
      assert_select "input#product_title[name=?]", "product[title]"
      assert_select "textarea#product_description[name=?]", "product[description]"
      assert_select "input#product_category[name=?]", "product[category]"
      assert_select "input#product_image_url[name=?]", "product[image_url]"
      assert_select "input#product_thumbnail_url[name=?]", "product[thumbnail_url]"
    end
  end
end
