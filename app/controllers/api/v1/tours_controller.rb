class Api::V1::ToursController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :current_user, only: %i[index show]
  before_action :set_tour, only: :show
  before_action :edit_tour, only: %i[update destroy]
  before_action :authorize_policy

  # GET /api/v1/tours
  def index
    @tours = policy_scope(Tour).where('time_start >= ?', Time.now)
    @tours = policy_scope(Tour).geolocation_filter(params[:geolocations]) if params[:geolocations].present?
    @tours = policy_scope(Tour).where(user_id: params[:user_id]) if params[:user_id].present?
    @tours = policy_scope(Tour).where(status: params[:status]) if params[:status].present?
    @tours = policy_scope(Tour).where('time_start < ?', Time.now) if params[:archived].present?

    authorize @tours

    if @tours
      render json: { data: @tours }, status: :ok
    else
      render json: @tours.errors, status: :bad_request
    end
  end

  # GET /api/v1/tours/1
  def show
    authorize @tour

    @places = @tour.places
    render json: { data: @tour, places: @places }, status: :ok
  end

  # POST /api/v1/tours
  def create
    @tour = Tour.new(permitted_attributes(Tour))

    authorize @tour

    if @tour.save
      render json: @tour, status: :created
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tours/1
  def update
    authorize @tour

    if @tour.update(tour_params)
      render json: { status: 'Update', data: @tour }, status: :ok
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tours/1
  def destroy
    authorize @tour

    if @tour.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tour
    @tour = policy_scope(Tour).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'tour id not found' }, status: :not_found
  end

  def edit_tour
    @tour = TourPolicy::EditScope.new(current_user, Tour).resolve.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'tour id not found' }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def tour_params
    params.require(:tour).permit(policy(@tour).permitted_attributes)
    # params.permit(:title, :description, :address_owner, :reg_code, :person, :seats, :price_per_one,
    #               :time_start, :time_end, :phone, :email, :user_id)
  end

  def authorize_policy
    authorize Tour
  end
end
