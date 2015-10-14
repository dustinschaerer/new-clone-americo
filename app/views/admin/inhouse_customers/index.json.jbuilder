json.array!(@inhouse_customers) do |inhouse_customer|
  json.extract! inhouse_customer, :email, :name, :date, :is_user
  json.url inhouse_customer_url(inhouse_customer, format: :json)
end