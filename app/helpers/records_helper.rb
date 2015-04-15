module RecordsHelper
	def correctlink(record, rec = nil)
		if rec.nil?
		 	nil
		 else
		 	if current_user.id == record.loanofficer_id or current_user.id == record.processor_id or current_user.profile.title == "admin" or current_user.profile.title == "master"
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
  def gravatar_for_rec(user,size)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		#gravatar_id = Digest::MD5::hexdigest("jordan.kay@gmail.com")
	  default_url = "http://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=#{CGI.escape(default_url)}"
    if !user.firstname.blank? and !user.lastname.blank?
    	image_tag(gravatar_url, alt: user.firstname + " " + user.lastname, class: "fullscreencenter")
    else
    	image_tag(gravatar_url, alt: user.email, class: "fullscreencenter")
    end
  end
end
