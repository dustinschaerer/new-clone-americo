class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :series_id
      t.string :name
      t.string :image_url

      t.timestamps
    end

    add_index :colors, :series_id
  end
end
