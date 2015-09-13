class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  require 'csv'
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv } #render text: @records.to_csv }
    end
  end
  def import
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      Contact.import(params[:file])
      redirect_to contacts_path, notice: "Records Imported"
    else
      redirect_to contacts_path, notice: "No Records Imported; You are not Admin."
    end
  end
  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create

    if !params[:record_id].blank?

      @record = Record.find(params[:record_id]) if !params[:record_id].blank?
      #Edit existing
      if !Contact.find_by_id(params[:commit]).blank?
        @contact = @record.contacts.find(params[:commit])
        if @contact.update(contact_params)
          redirect_to :back, notice: 'Contact information was successfully updated.'
        else
          redirect_to edit_record_path(@record), notice: 'Contact was not updated'
        end
    #create New
      else
        @contact = @record.contacts.build(contact_params)
        if !@contact.firstname.blank?
          if @contact.save
            redirect_to edit_record_path(@record)
          else
          end
        else
          redirect_to edit_record_path(@record), notice: 'Contact was not created.', alert: 'Cannot leave new firstname blank.'
        end
      end
    elsif !params[:profile_id].blank?
      @profile = Profile.find(params[:profile_id])
      #Edit existing
      if !Contact.find_by_id(params[:commit]).blank?
        @contact = @profile.contacts.find(params[:commit])
        if @contact.update(contact_params)
          redirect_to :back, notice: 'Contact information was successfully updated.'
        else
          redirect_to edit_profile_path(@profile), notice: 'Contact was not updated'
        end
    #create New
      else
        @contact = @profile.contacts.build(contact_params)
        if !@contact.firstname.blank?
          if @contact.save
            redirect_to edit_profile_path(@profile)
          else
          end
        else
          redirect_to edit_profile_path(@profile), notice: 'Contact was not created.', alert: 'Cannot leave new firstname blank.'
        end
      end
    end
  end

#  def create
#  @contact = Contact.new(contact_params)
#    respond_to do |format|
#      if @contact.save
#        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
#        format.json { render :show, status: :created, location: @contact }
#      else
#        format.html { render :new }
#      end
#    end
#        format.json { render json: @contact.errors, status: :unprocessable_entity }
#  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy

    if !params[:record_id].blank?
      @record = Record.find_by_id(params[:record_id])
      @contact.destroy
      redirect_to edit_record_path(@record), notice: 'Contact was successfully removed.'
    elsif !params[:profile_id].blank?
      @profile = Profile.find_by_id(params[:profile_id])
      @contact.destroy
      redirect_to edit_profile_path(@profile), notice: 'Contact was successfully removed.'
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:useme, :contacttype, :firstname, :lastname, :useemail, :email, :usephone, :phone, :other, :record_id, :profile_id, :updated_at)
    end
end
