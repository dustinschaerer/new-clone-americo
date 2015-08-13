class CreateEmailMessages < ActiveRecord::Migration
  def change
    create_table :email_messages do |t|
      t.string :subject
      t.string :headers
      t.text :content
      t.string :mandril_tags
      t.string :template

      t.timestamps
    end
  end
end
