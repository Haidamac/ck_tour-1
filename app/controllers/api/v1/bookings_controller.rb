class Api::V1::BookingsController < ApplicationController
  before_action :authorize_policy, only: %i[index list_for_partner]
  before_action :set_user, except: %i[create list_for_partner]
  before_action :set_accommodation, only: :list_for_partner
  before_action :set_room, only: %i[create list_for_partner]
  before_action :set_booking, only: %i[show update destroy]

  def index
    user_bookings = @user.bookings
    @bookings = if params[:archived].present?
                  policy_scope(user_bookings.archival_booking)
                else
                  policy_scope(user_bookings.upcoming_booking)
                end
    authorize @bookings

    if @bookings
      render json: { data: @bookings }, status: :ok
    else
      render json: @bookings.errors, status: :bad_request
    end
  end

  def show
    authorize @booking

    render json: @booking, status: :ok
  end

  def create
    @booking = @current_user.bookings.build(booking_params)

    authorize @booking

    if @booking.save
      BookingMailer.booking_confirmation(@booking.user, @booking).deliver_now
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @booking

    if @booking.update(edit_booking_params)
      render json: { status: 'Update', data: @booking }, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def destroy

    if @booking.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def list_for_partner
    room_bookings = @room.bookings
    @bookings = if params[:archived].present?
                  policy_scope(room_bookings.archival_booking)
                else
                  policy_scope(room_bookings.upcoming_booking)
                end

    if @bookings
      render json: { data: @bookings }, status: :ok
    else
      render json: @bookings.errors, status: :bad_request
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_accommodation
    @accommodation = Accommodation.find(params[:accommodation_id])
  end

  def set_room
    @room = Room.find_by_id(params[:room_id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.permit(:number_of_peoples, :check_in, :check_out, :note, :phone, :full_name, :room_id, :user_id)
  end

  def edit_booking_params
    params.permit(policy(@booking).permitted_attributes)
  end

  def authorize_policy
    authorize Booking
  end
end
