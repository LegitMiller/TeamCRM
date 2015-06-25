json.array!(@phasesteps) do |phasestep|
  json.extract! phasestep, :id, :finishedtime, :record_id, :phase_id
  json.url phasestep_url(phasestep, format: :json)
end
