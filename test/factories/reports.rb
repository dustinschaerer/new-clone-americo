FactoryGirl.define do
  factory :report do
    new_users 1
number_of_orders 1
number_of_quotes 1
number_of_purchases 1
amount_of_quotes "9.99"
amount_of_purchases "9.99"
catalogs_ordered 1
month 1
year 1
  end

end
