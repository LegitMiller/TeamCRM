json.array!(@phases) do |phase|
  json.extract! phase, :id, :name, :phase_id
  json.url phase_url(phase, format: :json)
end
