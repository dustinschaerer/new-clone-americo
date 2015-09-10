class AddKindToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :kind, :string
  end
end
