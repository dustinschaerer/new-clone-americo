class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :title
      t.string :category
      t.string :name
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
