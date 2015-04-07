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
end
