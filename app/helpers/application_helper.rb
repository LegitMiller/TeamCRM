module ApplicationHelper
	def sortable(column, title = nil)
	  title ||= column.titleize
	  if sort_column == column 
	  	testvar = true
	  end
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  if testvar == true
		  link_to title, {:sort => column, :direction => direction}, {:class => 'btn btn-default btn-xs btn-warning'}
	  else
		  link_to title, {:sort => column, :direction => direction}, {:class => 'btn btn-default btn-xs'}
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
  def editname(myid)
  	if User.exists?(myid) and myid == current_user.id
	    if current_user.profile.name.blank? 
	      link_to current_user.profile.email, edit_profile_path(current_user.id), :class => 'btn btn-default btn-xs'
	    else
	      link_to current_user.profile.name, edit_profile_path(current_user.id), :class => 'btn btn-default btn-xs'
	    end
  	else	
  		"none"
	  end
  end
end
