class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
  	@products = Product.order(:title)
    @series = Series.order(:name)
    @styles = Style.order(:name)
    @colors = Color.order(:name)

  end
end
