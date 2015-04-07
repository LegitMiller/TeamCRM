class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
#    @groups = Group.all
		@profiles = Profile.all
		@mylink = records_path
  end
  
  def mygroups
#  	@groups = current_user.owned_groups.order(:created_at)
  end
  
end
