require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :title => "Title",
      :description => "MyText",
      :category => "Category",
      :image_url => "Image Url",
      :thumbnail_url => "Thumbnail Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Category/)
    rendered.should match(/Image Url/)
    rendered.should match(/Thumbnail Url/)
  end
end
