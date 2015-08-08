class MessgsController < ApplicationController
  before_action :set_messg, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  require 'csv'
  # GET /messgs
  # GET /messgs.json
  def index
    @messgs = Messg.all
    respond_to do |format|
      format.html
      format.csv { send_data @messgs.to_csv } #render text: @records.to_csv }
    end
  end

  # GET /messgs/1
  # GET /messgs/1.json
  def show
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
    respond_to do |format|
      if @messg.update(messg_params)
        format.html { redirect_to @messg, notice: 'Messg was successfully updated.' }
        format.json { render :show, status: :ok, location: @messg }
      else
        format.html { render :edit }
        format.json { render json: @messg.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_messg
      @messg = Messg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def messg_params
      params.require(:messg).permit(:intro, :message, :closing, :progression_id, :updated_at)
    end
end
