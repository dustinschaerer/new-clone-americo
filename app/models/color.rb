class Color < ActiveRecord::Base
	belongs_to :series

	has_many :line_items
end
