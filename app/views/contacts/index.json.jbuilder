json.array!(@contacts) do |contact|
  json.extract! contact, :id, :useme, :coborrower, :firstname, :lastname, :useemail, :email, :usephone, :phone, :other, :record_id, :profile_id
  json.url contact_url(contact, format: :json)
end
