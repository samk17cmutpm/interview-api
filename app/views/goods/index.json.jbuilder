json.array!(@goods) do |good|
  json.extract! good, :id, :name, :quantity, :boat_id
  json.url good_url(good, format: :json)
end
