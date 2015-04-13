class Record < ActiveRecord::Base
	has_many :notes
  
  has_many :steps
  has_many :progressions, through: :steps

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
  		Record.all
  	end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |rec|
        csv << rec.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      record = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      record.update(parameters.permit(:firstname, :lastname, :phone, :email, :receivedate, :progress, :loanofficer_id, :processor_id))
      record.save!
    end
  end
  
end
