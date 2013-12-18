class LineItem < ActiveRecord::Base
  belongs_to :order	
  belongs_to :product
  belongs_to :cart
  belongs_to :style
  belongs_to :series
  belongs_to :color

  delegate :name, :category, :description, :image_url, to: :style, prefix: true

end
