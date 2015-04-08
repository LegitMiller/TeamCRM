json.array!(@progressions) do |progression|
  json.extract! progression, :id, :name, :phase_id
  json.url progression_url(progression, format: :json)
end
