class Product < ActiveRecord::Base

	validates :title, :description, :category, :image_url, :thumbnail_url, presence: true
	validates :title,  uniqueness: true
	validates :category, uniqueness: true

end
