class Step < ActiveRecord::Base
	belongs_to :record
	belongs_to :progression

end
