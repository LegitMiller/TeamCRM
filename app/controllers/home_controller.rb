class HomeController < ApplicationController
  before_action :authenticate_user!
 require 'csv'
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

    if current_user.profile.title == "master"
      @allusers = User.all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @allusers.to_csv } #render text: @records.to_csv }
    end
  end
  def import
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      User.import(params[:file])
      redirect_to root_path, notice: "Records Imported"
    else
      redirect_to root_path, notice: "No Records Imported; You are not Admin."
    end
  end
  def mygroups
#  	@groups = current_user.owned_groups.order(:created_at)
  end
  
end
