module ProfilesHelper

	  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user,size)  	
  	if user.email.blank?
			nil
		else
	    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
			#gravatar_id = Digest::MD5::hexdigest("jordan.kay@gmail.com")
		  default_url = "http://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png"
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=#{CGI.escape(default_url)}"
	    if !user.name.blank?
	    	image_tag(gravatar_url, alt: user.name, class: "fullscreencenter")
	    else
	    	image_tag(gravatar_url, alt: user.email, class: "fullscreencenter")
	    end
	  end
  end

  #def avatar_url(user)
	#  if user.avatar_url.present?
	#    user.avatar_url
	#  else
	#    default_url = "#{root_url}images/guest.png"
	#    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
	#    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
	#  end
	#end

end
