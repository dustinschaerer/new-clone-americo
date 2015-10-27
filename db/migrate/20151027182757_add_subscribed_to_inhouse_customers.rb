class AddSubscribedToInhouseCustomers < ActiveRecord::Migration
  def change
    add_column :inhouse_customers, :subscribed, :boolean, :default => true
  end
end
