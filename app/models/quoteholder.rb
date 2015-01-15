class Quoteholder < ActiveRecord::Base
	has_many :lines, dependent: :destroy

	def total_price
		lines.to_a.sum { |line| line.total_price }
	end

end
