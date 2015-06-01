class Notification < ActiveRecord::Base
has_one :user

	# Testing Purposes
  def self.createnotification(cuid, uid, recid, ctype, chtext, tuid = nil)
  	@notify = Notification.new(:maker_id => cuid, :user_id => uid, :thirdparty_id => tuid, :record_id => recid, :changetype => ctype, :change => chtext, :seen => false)
    if @notify.save
    	return true
    else
    	return false
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
      record.update(parameters.permit(:maker_id, :user_id, :thirdparty_id, :record_id, :changetype, :change, :updated_at))
      record.save!
    end
  end

end
