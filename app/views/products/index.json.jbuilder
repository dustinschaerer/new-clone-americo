json.array!(@products) do |product|
  json.extract! product, :title, :description, :category, :image_url, :thumbnail_url
  json.url product_url(product, format: :json)
end