json.array!(@steps) do |step|
  json.extract! step, :id, :record_id, :progression_id
  json.url step_url(step, format: :json)
end
