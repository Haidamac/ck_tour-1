class Api::V1::ReservationsController < ApplicationController
  before_action :authorize_policy, only: %i[index list_for_partner]
  before_action :set_user, except: %i[create list_for_partner]
  before_action :set_catering, only: %i[create list_for_partner]
  before_action :set_reservation, only: %i[show update destroy]

  def index
    user_reservations = @user.reservations
    @reservations = if params[:archived].present?
                      policy_scope(user_reservations.archival_reservation)
                    else
                      policy_scope(user_reservations.upcoming_reservation)
                    end

    if @reservations
      render json: { data: @reservations }, status: :ok
    else
      render json: @reservations.errors, status: :bad_request
    end
  end

  def list_for_partner
    catering_reservations = @catering.reservations
    @reservations = if params[:archived].present?
                      policy_scope(catering_reservations.archival_reservation)
                    else
                      policy_scope(catering_reservations.upcoming_reservation)
                    end

    if @reservations
      render json: { data: @reservations }, status: :ok
    else
      render json: @reservations.errors, status: :bad_request
    end
  end

  def show
    authorize @reservation

    render json: @reservation, status: :ok
  end

  def create
    @reservation = @current_user.reservations.build(reservation_params)

    authorize @reservation

    if @reservation.save
      # ReservationMailer.reservation_confirmation(@reservation.user, @reservation).deliver_now
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @reservation

    if @reservation.update(edit_reservation_params)
      render json: { status: 'Update', data: @reservation }, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @reservation

    if @reservation.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_catering
    @catering = Catering.find(params[:catering_id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.permit(:number_of_peoples, :check_in, :check_out, :note, :phone, :full_name, :catering_id, :user_id)
  end

  def edit_reservation_params
    params.permit(policy(@reservation).permitted_attributes)
  end

  def authorize_policy
    authorize Reservation
  end
end
