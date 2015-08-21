json.array!(@user_groups) do |user_group|
  json.extract! user_group, :name, :email_message_id, :last_sent_on
  json.url user_group_url(user_group, format: :json)
end