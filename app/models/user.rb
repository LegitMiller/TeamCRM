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
      hash = {}
      if find_by_id(row["id"]).blank?
        hash[:password] = "defaultpass"
        hash[:password_confirmation] = "defaultpass"
      end
      record = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      parameters = parameters.merge(hash)#
      record.update(parameters.permit(:email, :encrypted_password, :reset_password_token, :reset_password_send_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :password, :password_confirmation))
      record.save!
    end
  end



	
end
