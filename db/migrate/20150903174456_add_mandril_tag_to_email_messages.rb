class AddMandrilTagToEmailMessages < ActiveRecord::Migration
  def change
    add_column :email_messages, :mandril_tag, :string
  end
end
