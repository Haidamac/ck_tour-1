class Api::V1::GeolocationsController < ApplicationController
  include ResourceFinder
  before_action :set_geolocation, only: %i[show update destroy]
  skip_before_action :authenticate_request, only: %i[show]
  before_action :authorize_policy

  def show
    authorize @geolocation

    render json: @geolocation
  end

  def create
    @geolocation = parentable.geolocations.new(geolocation_params)

    authorize @geolocation

    if @geolocation.save
      render json: @geolocation, status: :created
    else
      render json: @geolocation.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @geolocation

    if @geolocation.update(geolocation_params)
      render json: { status: 'Update', data: @geolocation }, status: :ok
    else
      render json: @geolocation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @geolocation

    if @geolocation.destroy!
      render json: { status: 'Delete' }, status: :no_content
    else
      render json: @geolocation.errors, status: :unprocessable_entity
    end
  end

  private

  def set_geolocation
    @geolocation = parentable.geolocations
  end

  def geolocation_params
    params.permit(:latitude, :longitude)
  end

  def authorize_policy
    authorize Geolocation
  end
end
