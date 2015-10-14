class CreateInhouseGroups < ActiveRecord::Migration
  def change
    create_table :inhouse_groups do |t|
      t.string :name
      t.references :email_message, index: true
      t.date :last_sent_on

      t.timestamps
    end
  end
end
