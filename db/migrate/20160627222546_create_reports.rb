class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :new_users
      t.integer :number_of_orders
      t.integer :number_of_quotes
      t.integer :number_of_purchases
      t.decimal :amount_of_quotes, :precision => 8, :scale => 2
      t.decimal :amount_of_purchases
      t.integer :catalogs_ordered
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
