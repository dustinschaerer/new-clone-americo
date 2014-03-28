class Line < ActiveRecord::Base
  belongs_to :quote
  belongs_to :quoteholder
  belongs_to :quote_product
  belongs_to :cover
  belongs_to :series
  belongs_to :color
  belongs_to :shape
  belongs_to :size

  validates :quantity, presence: true, numericality: {:only_integer => true}
  validates :price, presence: true, numericality: true
  validates :shape_id, presence: true, if: :is_shape?
  validates :cover_id, presence: true, if: :is_cover?
  validates :series_id, presence: true, if: :is_series? 
  validates :color_id, presence: true, if: :is_color?
  validates :width, presence: true, if: :is_width?
  validates :width,  numericality: { greater_than_or_equal_to: 48 }, if: :is_americlear? 
  validates :width, numericality: { less_than_or_equal_to: 54 }, if: :is_americlear?
  validates :length, presence: true, if: :is_length?
  validates :length, presence: true, if: :is_other_length?
  validates :height, presence: true, if: :is_height?    
  validates :umbrella, presence: true, if: :is_umbrella?    
  validates :velcro, presence: true, if: :is_velcro?    
  validates :yards, presence: true, if: :is_yards?    


  def is_shape?
    (quote_product_id == 1) || (quote_product_id == 2)
  end    

  def is_cover?
    (quote_product_id == 1) || (quote_product_id == 2)
  end    

  def is_series?
    ( (quote_product_id == 1) || (quote_product_id == 2 ) || (quote_product_id == 7 ) ||
      (quote_product_id == 8) || (quote_product_id == 9 ) || (quote_product_id == 10 ) ||
      (quote_product_id == 11) || (quote_product_id == 12 ) || (quote_product_id == 13 ) )
  end
  
  def is_color?
    ( (quote_product_id == 1) || (quote_product_id == 2 ) || (quote_product_id == 7 ) ||
      (quote_product_id == 8) || (quote_product_id == 9 ) || (quote_product_id == 10 ) ||
      (quote_product_id == 11) || (quote_product_id == 12 ) || (quote_product_id == 13 ) )
  end

  def is_width?
    (quote_product_id == 1) || (quote_product_id == 2 ) ||
    (quote_product_id == 4) || (quote_product_id == 5 ) ||
    (quote_product_id == 6) 
  end

  def is_americlear?
    (quote_product_id == 6)  
  end  

  def is_length?
    # is table cloth and is rectangle
    if ((quote_product_id == 1) || (quote_product_id == 2 ))
      shape == 2
    end
  end

  def is_other_length?
    (quote_product_id == 5)
  end

  def is_height?
    (cover_id == 4) || (cover_id == 5)
  end

  def is_umbrella?
    (quote_product_id == 1) || (quote_product_id == 2 )
  end

  def is_velcro?
    (quote_product_id == 1) || (quote_product_id == 2 )
  end

  def is_yards?
    (quote_product_id == 6) || (quote_product_id == 7 ) ||
    (quote_product_id == 8) || (quote_product_id == 9 )
  end  
  
  def total_price
		price * quantity
	end	

end
