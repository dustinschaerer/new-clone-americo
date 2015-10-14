class CreateInhouseCustomers < ActiveRecord::Migration
  def change
    create_table :inhouse_customers do |t|
      t.string :email
      t.string :name
      t.date :date
      t.boolean :is_user

      t.timestamps
    end
  end
end
