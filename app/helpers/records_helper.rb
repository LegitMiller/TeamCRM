module RecordsHelper
	def correctlink(record, rec = nil, recl = nil)
		if rec.nil?
		 	nil
		else
		 	if current_user.id == record.loanofficer_id or current_user.id == record.processor_id or current_user.profile.title == "admin" or current_user.profile.title == "master" or current_user.id == record.marketer_id
		 		if record.firstname == rec
		 			if !recl.nil?
		 				link_to	rec + " " + recl, edit_record_path(record), :class => 'btn btn-default btn-xs'  
	 				else
	 					link_to rec, edit_record_path(record), :class => 'btn btn-default btn-xs'
		 			end
		 		else
			 		if !recl.nil?
			 			link_to	rec + " " + recl, edit_record_path(record) 
		 			else
		 				link_to rec, edit_record_path(record)
					end
				end
		 	else
			 	if !recl.nil? 
			 		link_to	rec + " " + recl, record
			 	else
			 		link_to	rec, record
			 	end
			end
		end
  end



	def getpname(myid)
		if !Progression.find_by_id(myid).blank? 
			Progression.find_by_id(myid).name
		end
  end
  def getname(myid, noclass = nil)
  	if User.exists?(myid)
  		if noclass == true
				myclass = ''
			else
				myclass = 'btn btn-default btn-xs'	      
      end	
    	uprofile = User.find(myid).profile
	    if uprofile.name.blank?
	      link_to uprofile.email, uprofile, :class => myclass
	    else
	      link_to uprofile.name, uprofile, :class => myclass
	    end
  	else	
  		"none"
	  end
  end




  def gravatar_for_rec(user,size)
  	if user.email.blank?
			nil
		else
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
end
