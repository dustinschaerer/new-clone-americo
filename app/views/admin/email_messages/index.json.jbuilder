json.array!(@admin_email_messages) do |admin_email_message|
  json.extract! admin_email_message, :subject, :headers, :content, :mandril_tags, :template
  json.url admin_email_message_url(admin_email_message, format: :json)
end