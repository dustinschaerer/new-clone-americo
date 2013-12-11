class Product < ActiveRecord::Base

	has_many :line_items
	has_many :orders, through: :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :category, :image_url, :thumbnail_url, presence: true
	validates :title,  uniqueness: true
	validates :category, uniqueness: true

	def self.latest
    	Product.order(:updated_at).last
  	end

	private

	  def ensure_not_referenced_by_any_line_item
        if line_items.empty?
          return true
        else
          errors.add(:base, 'Line Items present')	
          return false
        end
	 end
end
