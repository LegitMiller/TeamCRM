json.array!(@records) do |record|
  json.extract! record, :id, :firstname, :lastname, :phone, :email, :receivedate, :notes, :progress, :user_id
  json.url record_url(record, format: :json)
end
