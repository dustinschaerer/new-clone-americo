class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :style_id
      t.string :name
      t.text :description
      t.string :image_url

      t.timestamps
    end
    add_index :series, :style_id
  end
end
