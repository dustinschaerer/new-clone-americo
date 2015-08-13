class CreateProspectGroups < ActiveRecord::Migration
  def change
    create_table :prospect_groups do |t|
      t.string :name
      t.references :email_message, index: true
      t.date :last_sent_on

      t.timestamps
    end
  end
end
