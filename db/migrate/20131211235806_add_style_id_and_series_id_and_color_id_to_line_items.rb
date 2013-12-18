class AddStyleIdAndSeriesIdAndColorIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :style_id, :integer
    add_index :line_items, :style_id
    add_column :line_items, :series_id, :integer
    add_index :line_items, :series_id
    add_column :line_items, :color_id, :integer
    add_index :line_items, :color_id
  end
end
