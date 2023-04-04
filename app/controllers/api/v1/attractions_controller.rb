class Api::V1::AttractionsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[show index search]
  before_action :set_attraction, only: %i[show update destroy upload_image update_image]
  before_action :authorize_policy

  # GET /api/v1/attractions
  def index
    @attractions = if params[:geolocations].present?
                     Attraction.geolocation_filter(params[:geolocations])
                   elsif params[:search].present?
                     Attraction.all.joins(:geolocations).where('title||description||locality ILIKE ?', "%#{params[:search]}%")
                   else
                     Attraction.all
                   end

    authorize @attractions

    if @attractions
      # render json: { data: @attractions }, status: :ok
      render json: @attractions.as_json(include: :geolocations), status: :ok
    else
      render json: @attractions.errors, status: :bad_request
    end
  end

  # GET /api/v1/attractions/1
  def show
    authorize @attraction

    render json: @attraction.as_json(include: :geolocations), status: :ok
    # render json: @attraction.as_json(include: :geolocations), status: :ok
  end

  # POST /api/v1/attractions
  def create
    @attraction = Attraction.new(attraction_params)

    authorize @attraction

    if @attraction.save
      render json: { data: @attraction }, status: :created
    else
      render json: @attraction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/attractions/1
  def update
    authorize @attraction

    if @attraction.update(attraction_params)
      render json: { status: 'Update', data: @attraction }, status: :ok
    else
      render json: @attraction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/attractions/1
  def destroy
    authorize @attraction

    if @attraction.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @attraction.errors, status: :unprocessable_entity
    end
  end

  def upload_image
    @attraction.image.attach(params[:file])
    render json: { url: url_for(@attraction.image.variant(:main)) }
  end

  def update_image
    @attraction.image.attach(params[:blob_id])
    @attraction.update(image_url: params[:image_url])
    render json: { message: 'Image updated successfully' }
  end

  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'attraction id not found' }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def attraction_params
    params.permit(:title, :description)
  end

  def authorize_policy
    authorize Attraction
  end
end
