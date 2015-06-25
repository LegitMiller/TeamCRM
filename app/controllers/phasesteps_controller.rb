class PhasestepsController < ApplicationController
  before_action :set_phasestep, only: [:show, :edit, :update, :destroy]

  # GET /phasesteps
  # GET /phasesteps.json
  def index
    @phasesteps = Phasestep.all
  end

  # GET /phasesteps/1
  # GET /phasesteps/1.json
  def show
  end

  # GET /phasesteps/new
  def new
    @phasestep = Phasestep.new
  end

  # GET /phasesteps/1/edit
  def edit
  end

  # POST /phasesteps
  # POST /phasesteps.json
  def create
    @phasestep = Phasestep.new(phasestep_params)

    respond_to do |format|
      if @phasestep.save
        format.html { redirect_to @phasestep, notice: 'Phasestep was successfully created.' }
        format.json { render :show, status: :created, location: @phasestep }
      else
        format.html { render :new }
        format.json { render json: @phasestep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phasesteps/1
  # PATCH/PUT /phasesteps/1.json
  def update
    respond_to do |format|
      if @phasestep.update(phasestep_params)
        format.html { redirect_to @phasestep, notice: 'Phasestep was successfully updated.' }
        format.json { render :show, status: :ok, location: @phasestep }
      else
        format.html { render :edit }
        format.json { render json: @phasestep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phasesteps/1
  # DELETE /phasesteps/1.json
  def destroy
    @phasestep.destroy
    respond_to do |format|
      format.html { redirect_to phasesteps_url, notice: 'Phasestep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phasestep
      @phasestep = Phasestep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phasestep_params
      params.require(:phasestep).permit(:finishedtime, :record_id, :phase_id)
    end
end
