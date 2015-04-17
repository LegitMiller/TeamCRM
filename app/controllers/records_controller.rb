class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  require 'csv'

  # GET /records
  # GET /records.json
  def index
    #if sort_column.blank? #sort_direction.nil? || sort_column.nil?
    #  @records = Record.all
    #else
    #  #@records = Record.order(params[:sort])#.search(params[:search])
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      @records = Record.order(sort_column + " " + sort_direction)
    elsif current_user.profile.title == "processor"
      #@records = Record.where('progress= ? OR progress= ? OR processor_id= ?', 'appraisal ordered','appraisal received',current_user.id).order(sort_column + " " + sort_direction)
      @records = Record.where(processor_id: current_user.id).order(sort_column + " " + sort_direction)
    else 
      if params[:search].blank? || params[:search] ==''
        @records = Record.where(loanofficer_id: current_user.id).order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
    end
    respond_to do |format|
      format.html
      format.csv { send_data @records.to_csv } #render text: @records.to_csv }
    end
  end

  def import
    if current_user.profile.title == "admin"
      Record.import(params[:file])
      redirect_to records_path, notice: "Records Imported"
    else
      redirect_to records_path, notice: "No Records Imported; You are not Admin."
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
    @profiles= Profile.all
    @phases = Phase.all
    @progressions = Progression.all
    @steps = Record.find(params[:id]).steps
    
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
    elsif current_user.profile.title == "processor" 
      if Record.find_by_id(params[:id]).processor_id != current_user.id
        redirect_to records_path, notice: 'Unable to edit unowned record.'
      end
    else 
      if Record.find_by_id(params[:id]).loanofficer_id != current_user.id
        redirect_to records_path, notice: 'Unable to edit unowned record.'
      end
    end

  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        #format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.html { redirect_to records_path, notice: 'Record was successfully created.' }
        #format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    #rparams = params[:record]
    #testme = rparams[:progress]
    notificationprocess(@record.id, params[:record][:loanofficer_id], params[:record][:processor_id], params[:record][:progress]) 

    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to records_path, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy

    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      notificationsofdeath = Notification.where(:record_id => @record.id)
      notificationsofdeath.destroy_all
      @record.steps.destroy_all
      @record.notes.destroy_all
      @record.destroy
    elsif current_user.profile.title == "processor"
      @record.update_attributes :processor_id => "0"
    elsif current_user.profile.title == "loan officer"
      @record.update_attributes :loanofficer_id => "0"
    end
    respond_to do |format|
      format.html { redirect_to records_path, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def notificationprocess(recordid, recloid, recproid, recordprogress, mytype = nil)
    #CHECK TO SEE IF WE NEED TO MAKE A NOTIFICATION 

    @record = Record.find(recordid)
    if mytype == "phase" 
        mychange = "Phase: " + Phase.find(recordprogress).name
        oldchange = "'Not Done'"
    elsif mytype == "progression"# and recordprogress.to_i.is_a? Integer
      if Step.exists?(:record_id => recordid, :progression_id => recordprogress)
        mychange = "Progression Step: " + Progression.find(recordprogress).name
        oldchange = "'Done'"
      else
        mychange = "Progression Step: " + Progression.find(recordprogress).name
        oldchange = "'Not Done'"
      end
    elsif @record.progress != recordprogress.to_s
      mychange = "Progress"
      oldchange = @record.progress
      
      if recordprogress.to_s == "Completed"
        @myprofs = Profile.where(:title => "admin")
        @myprofs.each do |prof|
          Notification.createnotification(current_user.id, prof.id, @record.id, mychange, oldchange, 0)
        end
      end
    elsif @record.processor_id.to_i != recproid.to_i
      mychange = "Assigned Processor"
      oldchange = @record.processor_id
    elsif @record.loanofficer_id != recloid.to_i
      mychange = "Assigned Loan Officer"
      oldchange = @record.loanofficer_id
    end
    
    #USER REQUIREMENTS 
    if !mychange.blank?
      if current_user.id == @record.processor_id  
        if !@record.loanofficer_id.blank?
          #notify loan officer of all the actions the processor takes
          Notification.createnotification(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange)
        else !recloid.blank?  
          Notification.createnotification(current_user.id, recloid, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, recloid, @record.id, mychange, oldchange)
        end
      elsif current_user.id == @record.loanofficer_id 
        if !@record.processor_id.blank? 
          #notify processor of all the actions the loanofficer takes
          Notification.createnotification(current_user.id, @record.processor_id, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, @record.processor_id, @record.id, mychange, oldchange)
        else !recproid.blank?  
          Notification.createnotification(current_user.id, recproid, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, recproid, @record.id, mychange, oldchange)
        end
      else #if the admin changed something tell both the processor and the loan officer.

        if !@record.loanofficer_id.blank?
          #notify loan officer of all the actions the processor takes
          Notification.createnotification(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange, 0)
      #    checkmailer(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange)
        else !recloid.blank?  
          Notification.createnotification(current_user.id, recloid, @record.id, mychange, oldchange, 0)
      #    checkmailer(current_user.id, recloid, @record.id, mychange, oldchange)
        end
        if !@record.processor_id.blank? 
          #notify processor of all the actions the loanofficer takes
          Notification.createnotification(current_user.id, @record.processor_id, @record.id, mychange, oldchange, 0)
      #    checkmailer(current_user.id, @record.processor_id, @record.id, mychange, oldchange)
        else !recproid.blank?  
          Notification.createnotification(current_user.id, recproid, @record.id, mychange, oldchange, 0)
      #    checkmailer(current_user.id, recproid, @record.id, mychange, oldchange)
        end


        #  Notification.createnotification(current_user.id, @record.processor_id, @record.id, mychange, oldchange, 0)
        #  Notification.createnotification(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, @record.processor_id, @record.id, mychange, oldchange)
          #checkmailer(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange)
      end
    end
  end

  def checkmailer(efrom, eto, recordid, mychange, oldchange)
    if !eto.blank?
      record = Record.find(recordid)
      profile = Profile.find(eto)
      if mychange[0,5] == "Phase" 
        if record.phasemail == true
          UserMailer.record_email(efrom, eto, recordid, mychange, oldchange).deliver#phase_record_email(efrom, eto, recordid, mychange, oldchange).deliver
        end
        if profile.phasemail == true
          UserMailer.profile_email(efrom, eto, recordid, mychange, oldchange).deliver#phase_profile_email(efrom, eto, recordid, mychange, oldchange).deliver
        end
      elsif mychange[0,16] == "Progression Step"
        if record.progressmail == true 
          UserMailer.record_email(efrom, eto, recordid, mychange, oldchange).deliver#progression_record_email(efrom, eto, recordid, mychange, oldchange).deliver
        end
        if profile.progressmail == true
          UserMailer.profile_email(efrom, eto, recordid, mychange, oldchange).deliver#progression_profile_email(efrom, eto, recordid, mychange, oldchange).deliver
        end
      else #progress or assignment 
        if profile.assignmail == true
          UserMailer.profile_email(efrom, eto, recordid, mychange, oldchange).deliver#profile_email(efrom, eto, recordid, mychange, oldchange).deliver
        end
      end
    end
  end

  def addstep
    myrecord = Record.find(params[:id])
    notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, params[:progression_id], "progression") 
   
    Step.where(record_id: params[:id], progression_id: params[:progression_id]).first_or_create
    redirect_to edit_record_path(params[:id])

    #cycle through all the progressions and if phase is complete send another notification for phase complete - phase complete ones should trigger email.
    #put in a check box for if a client wants to recieve email updates on the client record thingy.

    myprogression = Progression.find(params[:progression_id])

    myphase = myprogression.phase

    phasecomplete = true
    
    myphase.progressions.each do |progression|
      if !Step.exists?(:record_id => params[:id], :progression_id => progression.id)
        phasecomplete = false
      end
    end 
    if phasecomplete == true
      #send notification for phase complete
      notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, myphase.id, "phase") 
    end

  end
  
  def removestep
    myrecord = Record.find(params[:id])
    notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, params[:progression_id]) 
   
    Step.where(record_id: params[:id], progression_id: params[:progression_id]).destroy_all
    redirect_to edit_record_path(params[:id])
  end

  private

  def sort_column
    Record.column_names.include?(params[:sort]) ? params[:sort] : "firstname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:firstname, :lastname, :phone, :email, :receivedate, :progress, :progressmail, :phasemail, :lopay, :propay, :jpay, :opay, :loanofficer_id, :processor_id)
    end
end
