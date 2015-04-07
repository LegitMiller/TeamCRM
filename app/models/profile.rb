class Profile < ActiveRecord::Base
	belongs_to :user
	#has_one :upline

	def self.search(search)
		if search
    		#find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    		results = where('firstname LIKE ?', "%#{search}%")
    		if !results.blank? 
    			results
    		else
    			results = where('lastname LIKE ?', "%#{search}%")	
	    		if !results.blank? 
	    			results
	    		else
					#ADD search by username
    			#results = where('%#{user.find_by_id(group.user_id).profile.fname}% LIKE ?', "%#{search}%")	
	    			results
	    		end

    		end
    	else
    		Profile.all
    	end
    end
end
