class LocationsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :edit, :create, :update, :destroy, :add_images, :calendar, :add_available_dates]
  before_action :set_location, only: [:show, :edit, :update, :destroy, :add_images, :calendar, :add_available_dates]

  # GET /locations
  # GET /locations.json
  def index
    if params[:start_date].present? || params[:end_date].present? || params[:address].present? || params[:musical_instrument].present? || params[:guests].present?
      @locations = SearchForLocationService.new({
        start_date: params[:start_date],
        end_date: params[:end_date],
        address: params[:address],
        musical_instrument: params[:musical_instrument],
        guests: params[:guests]
      }).matches.includes(:location_images, :member).page(params[:page]).per(10)
    else
      @locations = Location.all.includes(:location_images, :member).page(params[:page]).per(10)
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
     @available_dates = @location.available_dates.where(booked: false).pluck(:date).as_json
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    authorize @location
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        #byebug
        format.html { redirect_to add_images_location_path(@location), notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    authorize @location
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    authorize @location
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_images   
  end

  def calendar
    authorize @location
  end

  def add_available_dates
    @location.create_available_dates(params[:start_date], params[:end_date])
    redirect_to calendar_location_path(@location), notice: "Successfully added available dates"
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:title, :description, :address_1, :address_2, :city, 
        :state, :postcode, :musical_instrument, :night_rate, :guests, :member_id,
        location_images_attributes: [:id, :picture, :picture_order, :_destroy, :location_id])
    end
end
