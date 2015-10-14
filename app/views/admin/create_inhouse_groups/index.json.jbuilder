json.array!(@create_inhouse_groups) do |create_inhouse_group|
  json.extract! create_inhouse_group, :name, :email_message_id, :last_sent_on
  json.url create_inhouse_group_url(create_inhouse_group, format: :json)
end