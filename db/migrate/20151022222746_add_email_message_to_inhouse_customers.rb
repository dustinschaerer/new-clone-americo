class AddEmailMessageToInhouseCustomers < ActiveRecord::Migration
  def change
    add_reference :inhouse_customers, :email_message, index: true
    add_column :inhouse_customers, :last_sent_on, :date
  end
end
