class AddInConstantContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :in_constant_contact, :boolean, null: false, default: false
  end
end
