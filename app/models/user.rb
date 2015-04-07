class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
#  has_many :owned_groups, class_name: 'Group'
#  has_many :members
#  has_many :groups, :through => :members#, :source => 'groups'
  has_one :profile
  has_many :notifications
  	#scope :recent_occasions, order('dateg desc')
			#@user.recent_occasions.each do |o|



#  has_many :guests
#  has_many :events, :through => :guests

  #has_one :upline, class_name: 'User', :through => :profile, :foreign_key=>"upline" #no good because its called upline not user_id , :foreign_key=>"upline"
	


	
end
