json.array!(@sent_emails) do |sent_email|
  json.extract! sent_email, :email_message_id, :sendable_id, :sendable_type, :actual_recipients, :recipient_count, :sent_at
  json.url sent_email_url(sent_email, format: :json)
end