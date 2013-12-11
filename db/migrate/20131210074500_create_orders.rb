class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :ship_street_address
      t.string :ship_city
      t.string :ship_state
      t.string :ship_country
      t.string :telephone
      t.string :email

      t.timestamps
    end
  end
end
