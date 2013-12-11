json.array!(@orders) do |order|
  json.extract! order, :name, :ship_street_address, :ship_city, :ship_state, :ship_country, :telephone, :email
  json.url order_url(order, format: :json)
end