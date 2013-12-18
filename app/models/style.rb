class Style < ActiveRecord::Base
	has_many :series

	has_many :line_items
end
