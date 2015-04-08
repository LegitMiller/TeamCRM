class Phase < ActiveRecord::Base
		has_one :phase
		belongs_to :phase
		has_many :progressions
end
