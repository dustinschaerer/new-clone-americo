class AddAccountNumberToInhouseCustomers < ActiveRecord::Migration
  def change
    add_column :inhouse_customers, :account_number, :integer
    add_column :inhouse_customers, :contact, :string
  end
end
