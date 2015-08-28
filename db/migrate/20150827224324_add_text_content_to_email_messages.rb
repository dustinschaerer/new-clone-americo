class AddTextContentToEmailMessages < ActiveRecord::Migration
  def change
    add_column :email_messages, :text_content, :text
  end
end
