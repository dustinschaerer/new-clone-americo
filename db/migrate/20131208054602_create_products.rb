class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :image_url
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
