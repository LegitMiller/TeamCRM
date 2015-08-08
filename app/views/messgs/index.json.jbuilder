json.array!(@messgs) do |messg|
  json.extract! messg, :id, :intro, :message, :closing, :progression_id
  json.url messg_url(messg, format: :json)
end
