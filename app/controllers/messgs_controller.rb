class MessgsController < ApplicationController
  before_action :set_messg, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  require 'csv'
  # GET /messgs
  # GET /messgs.json
  def index
    @messgs = Messg.all

    if !params[:recordid].blank?
      @myrecord = Record.find(params[:recordid])
    else
    end

    respond_to do |format|
      format.html
      format.csv { send_data @messgs.to_csv } #render text: @records.to_csv }
    end
  end

  def import
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      Messg.import(params[:file])
      redirect_to messgs_path, notice: "Records Imported"
    else
      redirect_to messgs_path, notice: "No Records Imported; You are not Admin."
    end
  end
  # GET /messgs/1
  # GET /messgs/1.json
  def show
    if !params[:recordid].blank?
      @myrecord = Record.find(params[:recordid])

    else
      #return redirect_to(root_path)
    end

  end

  # GET /messgs/new
  def new
    @messg = Messg.new
  end

  # GET /messgs/1/edit
  def edit
  end

  # POST /messgs
  # POST /messgs.json
  def create
    @messg = Messg.new(messg_params)

    respond_to do |format|
      if @messg.save
        format.html { redirect_to @messg, notice: 'Messg was successfully created.' }
        format.json { render :show, status: :created, location: @messg }
      else
        format.html { render :new }
        format.json { render json: @messg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messgs/1
  # PATCH/PUT /messgs/1.json
  def update
    if params[:commit] == "Send"
      sendcustom(params[:id], params[:messg][:recordid], params[:messg][:message], params[:messg][:admin], params[:messg][:marketer], params[:messg][:borrower], params[:messg][:coborrower], params[:messg][:realtor], params[:messg][:escrowofficer], params[:messg][:loanofficer], params[:messg][:processor])
      redirect_to edit_record_path(params[:messg][:recordid]), notice: 'Message was Sent Successfully!'
    else
      respond_to do |format|
        if @messg.update(messg_params)
          if @messg.progression_id.blank?
            format.html { redirect_to messgs_path, notice: 'Messg was successfully updated.' }
          else
            format.html { redirect_to phases_path, notice: 'Messg was successfully updated.' }
            format.json { render :show, status: :ok, location: @messg }
          end
        else
          format.html { render :edit }
          format.json { render json: @messg.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /messgs/1
  # DELETE /messgs/1.json
  def destroy
    @messg.destroy
    respond_to do |format|
      format.html { redirect_to messgs_url, notice: 'Messg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sendupdate
    #myrecord = Record.find(params[:id])
    redirect_to :controller => 'messgs', :action => 'index', :recordid => params[:id] #myrecord.id
  end


  def sendcustom(messgid, recordid, msg, badmin, bmarketer, bborrower, bcoborrower, brealtor, bescrow, bloan, bprocessor)

    @messg = Messg.find_by_id(messgid)
    @record = Record.find_by_id(recordid)
    message = @messg.message
    textmsg = @messg.intro
    subject = "Loan Status Update"


    if !subject.blank? && !message.blank? && !@record.firstname.blank?
      if bborrower == "1"
        #we have to figure out how to add more email addresses
        #UserMailer.send_simple(@record.firstname + " " + @record.lastname, @record.email, subject, message) #don't send to this information just to the contact info.
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject, message) if contact.useme == true && contact.useemail == true && contact.contacttype == "borrower"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "borrower"
        end
      end
      if bcoborrower == "1"
        #we have to figure out how to add more co-borrowers to the account
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject, message) if contact.useme == true && contact.useemail == true && contact.contacttype == "coborrower"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "coborrower"
        end
      end
      if bloan == "1" && !@record.loanofficer_id.blank?
        @prof = Profile.find_by_id(@record.loanofficer_id)
        subject2 = "Superior Lending Client update"
        message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true && contact.contacttype == "loanofficer"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "loanofficer"
        end
        @prof.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
          UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
        end
      end
      if bprocessor == "1" && !@record.processor_id.blank?
        @prof = Profile.find_by_id(@record.processor_id)
        subject2 = "Superior Lending Client update"
        message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true && contact.contacttype == "processor"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "processor"
        end
        @prof.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
          UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
        end
      end
      if brealtor == "1" && !@record.real_id.blank?
        @prof = Profile.find_by_id(@record.real_id)
        subject2 = "Superior Lending Client update"
        message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true && contact.contacttype == "realtor"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "realtor"
        end
        @prof.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
          UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
        end
      end
      if bescrow == "1" && !@record.escrow_id.blank?
        @prof = Profile.find_by_id(@record.escrow_id)
        subject2 = "Superior Lending Client update"
        message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true && contact.contacttype == "escrowofficer"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "escrowofficer"
        end
        @prof.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
          UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
        end
      end
      if bmarketer == "1" && !@record.marketer_id.blank?
        @prof = Profile.find_by_id(@record.marketer_id)
        subject2 = "Superior Lending Client update"
        message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
        @record.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(contact.firstname + " " + contact.lastname, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true && contact.contacttype == "marketer"
          UserMailer.send_phone(contact.firstname + " " + contact.lastname, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true && contact.contacttype == "marketer"
        end
        @prof.contacts.order(:created_at).each do |contact|
          UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
          UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
        end
      end
      if badmin == "1"
        #figure out how to send to all admins in a loop.
        @profiles.each do |profile|
          if profile.title == "admin"
            @prof = profile
            subject2 = "Superior Lending Client update"
            message2 = @record.firstname + " " + @record.lastname + " was sent the folling message: "
            @prof.contacts.order(:created_at).each do |contact|
              UserMailer.send_simple(@prof.name, contact.email, subject2, message2 + message) if contact.useme == true && contact.useemail == true
              UserMailer.send_phone(@prof.name, contact.phone, message2 + @messg.intro) if contact.useme == true && contact.usephone == true
            end
          end
        end

      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_messg
      @messg = Messg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def messg_params
      params.require(:messg).permit(:intro, :message, :closing, :admin, :master, :borrower, :coborrower, :processor, :realtor, :loanofficer, :escrowofficer, :marketer, :progression_id, :updated_at)
    end
end
