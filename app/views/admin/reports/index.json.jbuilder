json.array!(@reports) do |report|
  json.extract! report, :new_users, :number_of_orders, :number_of_quotes, :number_of_purchases, :amount_of_quotes, :amount_of_purchases, :catalogs_ordered, :month, :year
  json.url report_url(report, format: :json)
end