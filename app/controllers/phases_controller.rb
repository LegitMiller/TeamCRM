class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /phases
  # GET /phases.json
  def index
    @phases = Phase.all
    @progressions = Progression.all
  end

  # GET /phases/1
  # GET /phases/1.json
  def show
  end

  # GET /phases/new
  def new
    if current_user.profile.title == "admin"
      @phase = Phase.new
    else
      redirect_to root_path
    end
  end

  # GET /phases/1/edit
  def edit
    if current_user.profile.title == "admin"
    else
      redirect_to root_path
    end
  end

  # POST /phases
  # POST /phases.json
  def create
    if current_user.profile.title == "admin"
      @phase = Phase.new(phase_params)

      respond_to do |format|
        if @phase.save
          format.html { redirect_to @phase, notice: 'Phase was successfully created.' }
          format.json { render :show, status: :created, location: @phase }
        else
          format.html { render :new }
          format.json { render json: @phase.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /phases/1
  # PATCH/PUT /phases/1.json
  def update
    if current_user.profile.title == "admin"
      respond_to do |format|
        if @phase.update(phase_params)
          format.html { redirect_to @phase, notice: 'Phase was successfully updated.' }
          format.json { render :show, status: :ok, location: @phase }
        else
          format.html { render :edit }
          format.json { render json: @phase.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /phases/1
  # DELETE /phases/1.json
  def destroy
    if current_user.profile.title == "admin"
      @phase.destroy
      respond_to do |format|
        format.html { redirect_to phases_url, notice: 'Phase was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_params
      params.require(:phase).permit(:name, :phase_id)
    end
end
