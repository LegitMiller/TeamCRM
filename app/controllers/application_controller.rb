class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def getname(myid, noclass = nil)
  	if User.exists?(myid)
  		if noclass == true
				myclass = ''
			else
				myclass = 'btn btn-default btn-xs'	      
      end	
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
