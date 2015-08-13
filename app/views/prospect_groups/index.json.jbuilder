json.array!(@prospect_groups) do |prospect_group|
  json.extract! prospect_group, :name, :email_message_id, :last_sent_on
  json.url prospect_group_url(prospect_group, format: :json)
end