class AddMailerMethodToEmailMessages < ActiveRecord::Migration
  def change
    add_column :email_messages, :mailer_method, :string
  end
end
