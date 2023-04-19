class Api::V1::AppointmentsController < ApplicationController
  before_action :authorize_policy, only: %i[index list_for_partner]
  before_action :set_user, except: %i[list_for_partner create]
  before_action :set_tour, only: %i[list_for_partner create]
  before_action :set_appointment, only: %i[show update destroy]

  def index
    user_appointments = @user.appointments
    @appointmentss = if params[:archived].present?
                       policy_scope(user_appointments.archival_booking)
                     else
                       policy_scope(user_appointments.upcoming_booking)
                     end

    if @appointments
      render json: { data: @appointments }, status: :ok
    else
      render json: @appointments.errors, status: :bad_request
    end
  end

  def list_for_partner
    tour_appointments = @tour.appointments
    @appointments = if params[:archived].present?
                      policy_scope(tour_appointments.archival_booking)
                    else
                      policy_scope(tour_appointments.upcoming_booking)
                    end

    if @appointments
      render json: { data: @appointments }, status: :ok
    else
      render json: @appointments.errors, status: :bad_request
    end
  end

  def show
    authorize @appointment

    render json: @appointment, status: :ok
  end

  def create
    @appointment = @current_user.appointments.build(appointment_params)

    authorize @appointment

    if @appointment.save
      AppointmentMailer.appointment_confirmation(@appointment.user, @appointment).deliver_now
      AppointmentMailer.appointment_tourist(@appointment.user, @appointment).deliver_now
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @appointment

    if @appointment.update(edit_appointment_params)
      render json: { status: 'Update', data: @appointment }, status: :ok
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @appointment

    if @appointment.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def appointment_params
    params.permit(:number_of_peoples, :note, :phone, :full_name, :tour_id, :user_id)
  end

  # Only allow a list of trusted parameters through.
  def edit_appointment_params
    params.permit(policy(@appointment).permitted_attributes)
  end

  def authorize_policy
    authorize Appointment
  end
end
