json.array!(@notes) do |note|
  json.extract! note, :id, :title, :comment, :user_id, :record_id
  json.url note_url(note, format: :json)
end
