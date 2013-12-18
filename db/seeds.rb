# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

Product.delete_all

Product.create!(title: 'Vinyl Swatch Sample',
  description: 
    %{<p>
       8" x 10" vinyl swatch sample. 
      </p>},
  category:      'Vinyl',
  image_url:     'vinyltablecover.jpg',    
  thumbnail_url: 'vinyltablecover-thumb.jpg')


# . . .
Product.create!(title: 'Laminate Swatch Sample',
  description: 
    %{<p>
       8" x 10" laminate swatch sample. 
      </p>},
  category:      'Laminate',
  image_url:     'laminatetablecover.jpg',    
  thumbnail_url: 'laminatetablecover-thumb.jpg')

# . . .
Product.create!(title: 'Slip-Knot Padding Sample',
  description: 
    %{<p>
       8" x 10" sample of slip-knot padding. 
      </p>},
  category:      'Slip Knot Padding',
  image_url:     'slipknot-padding.jpg',    
  thumbnail_url: 'slipknot-padding-thumb.jpg')

Product.create!(title: 'White Vinyl Padding Sample',
  description: 
    %{<p>
       8" x 10" sample of white vinyl padding. 
      </p>},
  category:      'Vinyl Padding',
  image_url:     'whitevinylpadding.jpg',    
  thumbnail_url: 'whitevinylpadding-thumb.jpg')

