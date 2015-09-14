class AddEmailMessageToProspects < ActiveRecord::Migration
  def change
    add_reference :prospects, :email_message, index: true
    add_column :prospects, :last_sent_on, :date
  end
end
