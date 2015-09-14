class AddEmailMessageToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :email_message, index: true
    add_column :users, :last_sent_on, :date
  end
end
