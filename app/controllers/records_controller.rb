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


    @listofcolors = { 0=> "default", 1=> "danger", 2=> "warning", 3=> "success", 4=> "info", 5=> "active", 6=> "active"}
    @phases = Phase.all
    @progressions = Progression.all

    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      if params[:search].blank? || params[:search] ==''
        @records = Record.order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
    elsif current_user.profile.title == "processor"
      #@records = Record.where('progress= ? OR progress= ? OR processor_id= ?', 'appraisal ordered','appraisal received',current_user.id).order(sort_column + " " + sort_direction)
      if params[:search].blank? || params[:search] ==''
        @records = Record.where(processor_id: current_user.id).order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
    elsif current_user.profile.title == "marketer" 
      if params[:search].blank? || params[:search] ==''
        @records = Record.where(marketer_id: current_user.id).order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
    elsif current_user.profile.title == "realtor"
      if params[:search].blank? || params[:search] ==''
        @records = Record.where(real_id: current_user.id).order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
    elsif current_user.profile.title == "escrow officer"
      if params[:search].blank? || params[:search] ==''
        @records = Record.where(escrow_id: current_user.id).order(sort_column + " " + sort_direction)
      else
        @records = Record.search(params[:search])
      end
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
  
  def inactive
    @records = Record.order(sort_column + " " + sort_direction)
  end
  
  def import
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      Record.import(params[:file])
      redirect_to records_path, notice: "Records Imported"
    else
      redirect_to records_path, notice: "No Records Imported; You are not Admin."
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @profiles= Profile.all
    @phases = Phase.all
    @progressions = Progression.all
    @steps = Record.find(params[:id]).steps
    
    @listoflos = [] 
    @listofpros = []
    @listofmars = []
    @listofRA = []
    @listofEO = []
    mynewprofile = Profile.new
    mynewprofile.id = "0"
    mynewprofile.name = "none"
    @listoflos.push(mynewprofile)
    @listofpros.push(mynewprofile)
    @listofmars.push(mynewprofile)
    @listofRA.push(mynewprofile)
    @listofEO.push(mynewprofile)
    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "loan officer"
      @listofpros.push(profile) if profile.title == "processor"
      @listofRA.push(profile) if profile.title == "realtor"
      @listofEO.push(profile) if profile.title == "escrow officer"
      @listofmars.push(profile) if profile.title == "loan officer"
      @listofmars.push(profile) if profile.title == "processor"
      @listofmars.push(profile) if profile.title == "marketer"
    end

    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "admin"
      @listofpros.push(profile) if profile.title == "admin"
      @listofmars.push(profile) if profile.title == "admin"
    end

  end

  # GET /records/new
  def new
    @record = Record.new
    @profiles= Profile.all
    
    @listoflos = [] 
    @listofpros = []
    @listofmars = []
    @listofRA = []
    @listofEO = []
    mynewprofile = Profile.new
    mynewprofile.id = "0"
    mynewprofile.name = "none"
    @listoflos.push(mynewprofile)
    @listofpros.push(mynewprofile)
    @listofmars.push(mynewprofile)
    @listofRA.push(mynewprofile)
    @listofEO.push(mynewprofile)
    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "loan officer"
      @listofpros.push(profile) if profile.title == "processor"
      @listofRA.push(profile) if profile.title == "realtor"
      @listofEO.push(profile) if profile.title == "escrow officer"
      @listofmars.push(profile) if profile.title == "loan officer"
      @listofmars.push(profile) if profile.title == "processor"
      @listofmars.push(profile) if profile.title == "marketer"
    end

    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "admin"
      @listofpros.push(profile) if profile.title == "admin"
      @listofmars.push(profile) if profile.title == "admin"
    end

  end

  # GET /records/1/edit
  def edit
    @profiles= Profile.all
    @phases = Phase.all
    @progressions = Progression.all
    @steps = Record.find(params[:id]).steps
    
    @listoflos = [] 
    @listofpros = []
    @listofmars = []
    @listofRA = []
    @listofEO = []
    mynewprofile = Profile.new
    mynewprofile.id = "0"
    mynewprofile.name = "none"
    @listoflos.push(mynewprofile)
    @listofpros.push(mynewprofile)
    @listofmars.push(mynewprofile)
    @listofRA.push(mynewprofile)
    @listofEO.push(mynewprofile)
    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "loan officer"
      @listofpros.push(profile) if profile.title == "processor"
      @listofRA.push(profile) if profile.title == "realtor"
      @listofEO.push(profile) if profile.title == "escrow officer"
      @listofmars.push(profile) if profile.title == "loan officer"
      @listofmars.push(profile) if profile.title == "processor"
      @listofmars.push(profile) if profile.title == "marketer"
    end

    @profiles.each do |profile|  
      @listoflos.push(profile) if profile.title == "admin"
      @listofpros.push(profile) if profile.title == "admin"
      @listofmars.push(profile) if profile.title == "admin"
    end
          





    if current_user.profile.title == "admin" or current_user.profile.title == "master"
    elsif current_user.profile.title == "processor" 
      if Record.find_by_id(params[:id]).processor_id != current_user.id
        redirect_to records_path, notice: 'Unable to edit unowned record.'
      end
    elsif current_user.profile.title == "loan officer"  
      if Record.find_by_id(params[:id]).loanofficer_id != current_user.id
        redirect_to records_path, notice: 'Unable to edit unowned record.'
      end
    elsif current_user.profile.title == "marketer"  
      if Record.find_by_id(params[:id]).marketer_id != current_user.id
        redirect_to records_path, notice: 'Unable to edit unowned record.'
      end
    else  
        redirect_to records_path, notice: 'Unable to edit unowned record.'
    end

  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        #format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.html { redirect_to root_path, notice: 'Record was successfully created.' }
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

    notificationprocess(@record.id, params[:record][:loanofficer_id], params[:record][:processor_id], params[:record][:marketer_id], params[:record][:real_id], params[:record][:escrow_id], params[:record][:progress]) 

    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to edit_record_path(@record), notice: 'Record was successfully updated.' }#records_path
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
    elsif current_user.profile.title == "marketer"
      @record.update_attributes :marketer_id => "0"
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def notificationprocess(recordid, recloid, recproid, recmark, recreal, recescrow, recordprogress, mytype = nil)
    #CHECK TO SEE IF WE NEED TO MAKE A NOTIFICATION 
    #make a list of new people (people who are assigned currently. they may also be old people.)
    #for the list of new people produce every notification about every change, but only do it for people other than the current user.
    #for each notification made in this process - check to see if we should make a email notification
    #for each of the first "new" people's notification made in this process - check to see if we need to make a notification for the client.

    @record = Record.find(recordid)
    
    listofnewpeeps = []
    
    listofnewpeeps.push(Profile.find_by_id(recloid)) if !Profile.find_by_id(recloid).blank? 
    listofnewpeeps.push(Profile.find_by_id(recproid)) if !Profile.find_by_id(recproid).blank? 
    listofnewpeeps.push(Profile.find_by_id(recmark)) if !Profile.find_by_id(recmark).blank? 
    listofnewpeeps.push(Profile.find_by_id(recreal)) if !Profile.find_by_id(recreal).blank? 
    listofnewpeeps.push(Profile.find_by_id(recescrow)) if !Profile.find_by_id(recescrow).blank? 

    Profile.where(:title => "admin").each do |prof|
      listofnewpeeps.push(prof)
    end

    senttoclient = false

    listofnewpeeps.each do |peep|
 
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
        if recordprogress.to_s == "Completed" and peep.title == "admin"
#Don't create notifications, they're just annoying at this point
#          Notification.createnotification(current_user.id, peep.id, @record.id, mychange, oldchange, 0)
          #checkmailer(current_user.id, peep.id, @record.id, mychange, oldchange, 0)
        end
      end

      #now that we've determined aspects of the notification, create the full notification.
      if !mychange.blank? and current_user.id != peep.id  
#Don't create notifications, they're just annoying at this point
#        Notification.createnotification(current_user.id, peep.id, @record.id, mychange, oldchange, 0)
        checkmailer(current_user.id, peep.id, @record.id, mychange, oldchange, recordprogress || "" )

        if senttoclient == false
          checkclientmailer(current_user.id, peep.id, @record.id, mychange, oldchange)
          senttoclient = true
        end
      end

    end

    #Send out Notifications to those who were removed from a record. Also send them an email automatically.

    if @record.loanofficer_id != recloid.to_i and current_user.id != @record.loanofficer_id and !recloid.blank?
      mychange = "Assigned Loan Officer"
      oldchange = @record.loanofficer_id
      newchange = recloid
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, @record.loanofficer_id, @record.id, mychange, oldchange, recloid)
    end
    if @record.processor_id.to_i != recproid.to_i and current_user.id != @record.processor_id  and !recproid.blank?
      mychange = "Assigned Processor"
      oldchange = @record.processor_id
      newchange = recproid
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, @record.processor_id, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, @record.processor_id, @record.id, mychange, oldchange, recproid)
    end
    if @record.marketer_id != recmark.to_i and current_user.id != @record.marketer_id and !recmark.blank?
      mychange = "Assigned Marketer"
      oldchange = @record.marketer_id
      newchange = recmark
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, @record.marketer_id, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, @record.marketer_id, @record.id, mychange, oldchange, recmark)
    end
    if @record.real_id != recreal.to_i and current_user.id != @record.real_id and !recreal.blank?
      mychange = "Assigned Realtor"
      oldchange = @record.real_id
      newchange = recreal
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, @record.real_id, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, @record.real_id, @record.id, mychange, oldchange, recreal)
    end
    if @record.escrow_id != recescrow.to_i and current_user.id != @record.escrow_id and !recescrow.blank?
      mychange = "Assigned Escrow Agent"
      oldchange = @record.escrow_id
      newchange = recescrow
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, @record.escrow_id, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, @record.escrow_id, @record.id, mychange, oldchange, recescrow)
    end
    
    #also notify the people who have been assigned to things.
    if @record.loanofficer_id != recloid.to_i and current_user.id != recloid.to_i and !recloid.blank?
      mychange = "Assigned Loan Officer"
      oldchange = @record.loanofficer_id
      newchange = recloid
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, recloid, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, recloid, @record.id, mychange, oldchange, recloid)
    end
    if @record.processor_id.to_i != recproid.to_i   and current_user.id != recproid.to_i and !recproid.blank?
      mychange = "Assigned Processor"
      oldchange = @record.processor_id
      newchange = recproid
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, recproid, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, recproid, @record.id, mychange, oldchange, recproid)
    end
    if @record.marketer_id != recmark.to_i  and current_user.id != recmark.to_i and !recmark.blank?
      mychange = "Assigned Marketer"
      oldchange = @record.marketer_id
      newchange = recmark
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, recmark, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, recmark, @record.id, mychange, oldchange, recmark)
    end
    if @record.real_id != recreal.to_i and current_user.id != recreal.to_i and !recreal.blank?
      mychange = "Assigned Realtor"
      oldchange = @record.real_id
      newchange = recreal
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id, recreal, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, recreal, @record.id, mychange, oldchange, recreal)
    end
    if @record.escrow_id != recescrow.to_i and current_user.id != recescrow.to_i and !recescrow.blank?
      mychange = "Assigned Escrow Agent"
      oldchange = @record.escrow_id
      newchange = recescrow
#Don't create notifications, they're just annoying at this point
#      Notification.createnotification(current_user.id,recescrow, @record.id, mychange, oldchange, newchange)
      checkmailer(current_user.id, recescrow, @record.id, mychange, oldchange, recescrow)
    end


  end

  def checkmailer(efrom, eto, recordid, mychange, oldchange, newchange = nil)
    if !eto.blank?
      temptime = Time.now
      record = Record.find(recordid)
      profile = Profile.find(eto)
      if User.exists?(efrom)
        uprofile = User.find(efrom).profile
        if uprofile.name.blank?
          fromname = uprofile.email
        else
          fromname = uprofile.name
        end
      else  
        fromname = "Unknown"
      end

      if (mychange[0,5] == "Phase" && profile.phasemail == true) || (mychange[0,16] == "Progression Step" && profile.progressmail == true)
        if oldchange == "'Done'"
          newname = "'Not Done'"
        else
          newname = "'Done'"
        end
        subject = "Progress made on " + record.firstname + " " + record.lastname + "'s Loan"
        message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + oldchange + " to " +  newname + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
      else #progress or assignment 
        if mychange == "Progress"
          subject = "Progress Update"
          message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + record.progress.to_s + " to " +  newchange.to_s + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
        else
          if profile.assignmail == true
            if mychange == "Assigned Loan Officer"
              subject = "Assignment Change"
              message = fromname + " changed " +  record.firstname + " " + record.lastname + "'s " + mychange + " from " + getname(record.loanofficer_id) + " to " + getname(newchange) + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
            elsif mychange == "Assigned Processor"
              subject = "Assignment Change"
              message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + getname(record.processor_id) + " to " + getname(newchange) + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
            elsif mychange == "Assigned Marketer"
              subject = "Assignment Change"
              message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + getname(record.marketer_id) + " to " + getname(newchange) + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
            elsif mychange == "Assigned Realtor"
              subject = "Assignment Change"
              message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + getname(record.real_id) + " to " + getname(newchange) + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
            elsif mychange == "Assigned Escrow Agent"
              subject = "Assignment Change"
              message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + getname(record.escrow_id) + " to " + getname(newchange) + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
            end
          end
        end
      end
      if !subject.blank? && !message.blank?
        UserMailer.send_simple(profile.name, profile.email, subject, message)
      end
    end
  end
  

  def checkclientmailer(efrom, eto, recordid, mychange, oldchange, newchange = nil)
    if !recordid.blank?
      record = Record.find(recordid)
      profile = Profile.find(eto)
      if User.exists?(efrom)
        uprofile = User.find(efrom).profile
        if uprofile.name.blank?
          fromname = uprofile.email
        else
          fromname = uprofile.name
        end
      else  
        fromname = "Unknown"
      end

      if (mychange[0,5] == "Phase" && record.phasemail == true) || (mychange[0,16] == "Progression Step" && record.progressmail == true)

        if oldchange == "'Done'"
          newname = "'Not Done'"
        else
          newname = "'Done'"
        end
        temptime = Time.now
        subject = "Progress has been made on " + record.firstname + " " + record.lastname + "'s Loan" #progress made on your loan!
        message = fromname + " changed " + record.firstname + " " + record.lastname + "'s " + mychange + " from " + newname + " to " + oldchange + " "+ temptime.strftime("on %m/%d/%Y") + " " + temptime.strftime("at %l:%M%p") +"."
        UserMailer.send_simple(record.firstname + " " + record.lastname, record.email, subject, message)
      else #progress or assignment 
      end

    end
  end


  def addstep
    myrecord = Record.find(params[:id])
    notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, myrecord.marketer_id, myrecord.real_id, myrecord.escrow_id, params[:progression_id], "progression") 
   
    #create step
    Step.where(record_id: params[:id], progression_id: params[:progression_id]).first_or_create
    
    #update the latest change.
    myrecord.update(:detailedprogress => params[:progression_id])
    
    #cycle through all the progressions and if phase is complete send another notification for phase complete - phase complete ones should trigger email.
    #put in a check box for if a client wants to recieve email updates on the client record thingy.

    #send notification for phase complete

    myprogression = Progression.find(params[:progression_id])
    myphase = myprogression.phase

    phasecomplete = true
    myphase.progressions.each do |progression|
      if !Step.exists?(:record_id => params[:id], :progression_id => progression.id)
        phasecomplete = false
      end
    end 
    if phasecomplete == true
      notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, myrecord.marketer_id, myrecord.real_id, myrecord.escrow_id, myphase.id, "phase") 
    end

    redirect_to edit_record_path(params[:id])

  end
  
  def removestep
    myrecord = Record.find(params[:id])
    notificationprocess(myrecord.id, myrecord.loanofficer_id, myrecord.processor_id, myrecord.marketer_id, myrecord.real_id, myrecord.escrow_id, params[:progression_id]) 
   
    Step.where(record_id: params[:id], progression_id: params[:progression_id]).destroy_all
    redirect_to edit_record_path(params[:id])
  end

  def inactive_content
    @records = Record.all
    respond_to do |format|               
      format.js
    end        
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
      params.require(:record).permit(:firstname, :lastname, :phone, :email, :raemail, :receivedate, :followupdate, :progress, :detailedprogress, :progressmail, :phasemail, :lopay, :propay, :jpay, :opay, :splitpay, :loanofficer_id, :processor_id, :marketer_id, :real_id, :escrow_id)
    end
end
