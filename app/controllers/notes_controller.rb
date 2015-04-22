class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  require 'csv'
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
    respond_to do |format|
      format.html
      format.csv { send_data @notes.to_csv } #render text: @records.to_csv }
    end
  end

  def import
    if current_user.profile.title == "admin" or current_user.profile.title == "master"
      Note.import(params[:file])
      redirect_to notes_path, notice: "Records Imported"
    else
      redirect_to notes_path, notice: "No Records Imported; You are not Admin."
    end
  end
  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    #@note = Note.new(note_params)
    @record = Record.find(params[:record_id])

    #Edit existing    
    if !Note.find_by_id(params[:commit]).blank?
      @note = @record.notes.find(params[:commit])
      if @note.update(note_params)
        redirect_to :back, notice: 'Note was successfully updated by you.'
      else
        redirect_to edit_envelope_path(@envelope), notice: 'Note was not updated'
      end
  #create New
    else
      @note = @record.notes.build(note_params)
      if !@note.comment.blank?
        if @note.save
          redirect_to edit_record_path(@record)
        else
        end
      else
        redirect_to edit_record_path(@record), notice: 'Note was not created.', alert: 'Cannot leave new commnent blank.'
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    #@note = Note.find(params[:id])
    @record = Record.find_by_id(params[:record_id])
    @note.destroy
    redirect_to edit_record_path(@record), notice: 'Note was successfully removed.'

    #@note.destroy
    #respond_to do |format|
    #  format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  #private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :comment, :user_id, :record_id)
    end
end
