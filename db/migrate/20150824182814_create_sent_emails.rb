class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.references :email_message, index: true
      t.references :sendable, polymorphic: true, index: true
      t.text :actual_recipients
      t.integer :recipient_count
      t.datetime :sent_at

      t.timestamps
    end
  end
end
