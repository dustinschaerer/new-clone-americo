json.array!(@mandril_tags) do |mandril_tag|
  json.extract! mandril_tag, :title
  json.url mandril_tag_url(mandril_tag, format: :json)
end