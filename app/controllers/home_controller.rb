class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
#    @groups = Group.all
		@profiles = Profile.all
		@mylink = records_path

		if current_user.profile.title == "admin" or current_user.profile.title == "master"
      @records = Record.all
    elsif current_user.profile.title == "processor"
      #@records = Record.where('progress= ? OR progress= ? OR processor_id= ?', 'appraisal ordered','appraisal received',current_user.id).order(sort_column + " " + sort_direction)
      @records = Record.where(processor_id: current_user.id)
    else 
      @records = Record.where(loanofficer_id: current_user.id)
    end
  end
  
  def mygroups
#  	@groups = current_user.owned_groups.order(:created_at)
  end
  
end
