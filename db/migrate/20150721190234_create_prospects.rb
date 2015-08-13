class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :email
      t.boolean :unsubscribed
      t.boolean :validated
      t.date :date_joined_on
      t.string :name

      t.timestamps
    end
  end
end
