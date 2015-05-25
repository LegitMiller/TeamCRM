module MailerHelper
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
	def gettextname(myid)
		if User.exists?(myid)
    	uprofile = User.find(myid).profile
	    if uprofile.name.blank?
	      uprofile.email
	    else
	      uprofile.name
	    end
  	else	
  		"none"
	  end
  end

end
