module HomeHelper

	def getupdated(record)
		if record.nil?
			nil
		else
			#get lastest step of that record
			#get lastest note of that record
			mytime = record.updated_at

			#no need to compare steps because it automatically updates the upsated time on the record when you add a step for some reason. So having this code in here just wastes time to load the page.
			#record.steps.each do |thestep|
			#	if mytime < thestep.updated_at
			#		mytime = thestep.updated_at
			#	end
			#end

			record.notes.each do |thenote|
				if mytime < thenote.updated_at
					mytime = thenote.updated_at
				end
			end
			mytime
		end
	end
end
