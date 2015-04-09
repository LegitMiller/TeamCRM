class ProgressionsController < ApplicationController
  before_action :set_progression, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /progressions
  # GET /progressions.json
  
  # GET /progressions/1/edit
  def edit
    if current_user.profile.title == "admin"
    else
      redirect_to root_path
    end
  end

  # POST /progressions
  # POST /progressions.json
  def create
    if current_user.profile.title == "admin"
      @progression = Progression.new(progression_params)

      respond_to do |format|
        if @progression.save
          format.html { redirect_to phases_path, notice: 'Progression was successfully created.' }
          format.json { render :show, status: :created, location: @progression }
        else
          format.html { render :new }
          format.json { render json: @progression.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /progressions/1
  # PATCH/PUT /progressions/1.json
  def update
    if current_user.profile.title == "admin"
      respond_to do |format|
        if @progression.update(progression_params)
          format.html { redirect_to phases_path, notice: 'Progression was successfully updated.' }
          format.json { render :show, status: :ok, location: @progression }
        else
          format.html { render :edit }
          format.json { render json: @progression.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end      
  end

  # DELETE /progressions/1
  # DELETE /progressions/1.json
  def destroy
    if current_user.profile.title == "admin" 
      @progression.destroy
      respond_to do |format|
        format.html { redirect_to phases_path, notice: 'Progression was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progression
      @progression = Progression.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progression_params
      params.require(:progression).permit(:name, :phase_id)
    end
end
