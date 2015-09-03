class RemoveMandrilTagsFromEmailMessages < ActiveRecord::Migration
  def up
    remove_column :email_messages, :mandril_tags
  end

  def down
    add_column :email_messages, :mandril_tags, :string
  end
end
