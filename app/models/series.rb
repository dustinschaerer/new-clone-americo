class Series < ActiveRecord::Base

	belongs_to :style

	has_many :line_items
end
