json.array!(@continents) do |continent|
  json.extract! continent, :id, :name
  json.url continent_url(continent, format: :json)
end
