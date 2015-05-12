json.array!(@cities) do |city|
  json.extract! city, :id, :name, :country_id, :created_at, :updated_at
end
