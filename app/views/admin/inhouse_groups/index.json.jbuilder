json.array!(@inhouse_groups) do |inhouse_group|
  json.extract! inhouse_group, :name, :email_message_id, :last_sent_on
  json.url inhouse_group_url(inhouse_group, format: :json)
end