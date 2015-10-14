class AddInhouseGroupToInhouseCustomers < ActiveRecord::Migration
  def change
    add_reference :inhouse_customers, :inhouse_group, index: true
  end
end
