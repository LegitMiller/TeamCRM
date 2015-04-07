module RecordsHelper
	def correctlink(record, rec = nil)
		if rec.nil?
		 	nil
		 else
		 	if current_user.id == record.loanofficer_id or current_user.id == record.processor_id or current_user.profile.title == "admin"
		 		if record.firstname == rec
		 			link_to	rec, edit_record_path(record), :class => 'btn btn-default btn-xs'
		 		else
					link_to	rec, edit_record_path(record)
				end
		 	else
		 		link_to	rec, record
		 	end
		 end
  end
end
