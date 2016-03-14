class BoatsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  # GET /boats
  # GET /boats.json
  def index
    @boats = Boat.all
  end

  # GET /boats/1
  # GET /boats/1.json
  def show

  end

  # GET /boats/new
  def new
    @boat = Boat.new
  end

  # GET /boats/1/edit
  def edit
  end

  # POST /boats
  # POST /boats.json
  def create
    @boat = Boat.new(boat_params)

    respond_to do |format|
      if @boat.save
        format.html { redirect_to @boat, notice: 'Boat was successfully created.' }
        format.json { render :show, status: :created, location: @boat }
      else
        format.html { render :new }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boats/1
  # PATCH/PUT /boats/1.json
  def update
    respond_to do |format|
      if @boat.update(boat_params)
        format.html { redirect_to @boat, notice: 'Boat was successfully updated.' }
        format.json { render :show, status: :ok, location: @boat }
      else
        format.html { render :edit }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boats/1
  # DELETE /boats/1.json
  def destroy
    @boat.destroy
    respond_to do |format|
      format.html { redirect_to boats_url, notice: 'Boat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_all
    boats = Boat.all
    boat_arr = []
    boats.each do |boat|
      hash = {
        :id => boat.id,
        :name => boat.name,
        :image => root_url + boat.image.to_s
      }
      boat_arr.push hash
    end
    render json: boat_arr
  end

  def get_boat
    if params.include?(:id)
      if Boat.exists?(:id => params[:id])
        boat = Boat.find_by(:id => params[:id])
        result = {
          :id => boat.id,
          :name => boat.name,
          :image => root_url + boat.image.to_s
        }
      else
        result = {:success => false, :message => 'Id does not exist'}
      end
    else
      result = {:success => false, :message => "Please check your paramaters !"}
    end
    render json: result
  end

  def get_goods
    if params.include?(:boat_id)
      if Boat.exists?(:id => params[:boat_id])
        result = Good.joins(:boat).where(boats: {id: [params[:boat_id]]})
      else
        result = {:success => false, :message => 'Id does not exist'}
      end
    else
      result = {:success => false, :message => 'Please check your paramaters'}
    end
    render json: result
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boat
      @boat = Boat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boat_params
      params.require(:boat).permit(:name, :image)
    end
end
