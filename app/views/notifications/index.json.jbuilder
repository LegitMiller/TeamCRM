json.array!(@notifications) do |notification|
  json.extract! notification, :id, :maker_id, :user_id, :thirdparty_id, :record_id, :changetype, :change
  json.url notification_url(notification, format: :json)
end
