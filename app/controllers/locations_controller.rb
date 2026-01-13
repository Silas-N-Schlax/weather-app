class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]


  # GET /locations or /locations.json
  def index
    @locations = Location.all
    @location = Location.new
  end

  # GET /locations/1 or /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    wrapper = LocationWrapper.new(location_params)
    result = wrapper.call
    puts result
    puts "#️⃣ Wrapper"
    @location = Location.new(
      name: location_params["name"],
      input: location_params["input"],
      lat: result["lat"],
      long: result["long"]
    )
    if result["error"]
      @location.errors.add(:base, result["reason"])
    end


    respond_to do |format|
      if @location.errors.any?
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@location, partial: "locations/form", locals: { location: @location })
        }
      elsif @location.save
        format.html { redirect_to locations_path, notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@location, partial: "locations/form", locals: { location: @location })
        }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: "Location was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_path, notice: "Location was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.expect(location: [ :name, :input ])
    end
end
