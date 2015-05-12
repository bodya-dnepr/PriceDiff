json.array!(@countries) do |country|
  json.extract! country, :id, :name, :created_at, :updated_at
end
