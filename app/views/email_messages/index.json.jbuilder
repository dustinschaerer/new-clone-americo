json.array!(@email_messages) do |email_message|
  json.extract! email_message, :subject, :headers, :content, :mandril_tags, :template
  json.url email_message_url(email_message, format: :json)
end