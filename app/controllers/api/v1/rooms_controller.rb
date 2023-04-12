class Api::V1::RoomsController < ApplicationController
  include Rails.application.routes.url_helpers
  skip_before_action :authenticate_request, only: %i[index show]
  before_action :set_accommodation
  before_action :set_room, only: %i[show update destroy]
  before_action :authorize_policy

  # GET /api/v1/accommodations/1/rooms
  def index
    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @number_of_peoples = params[:number_of_peoples]

    @rooms = if (@check_in && @check_out && @number_of_peoples).present?
               available_rooms
             else
               @accommodation.rooms.all
             end

    authorize @rooms

    if @rooms
      render json: { data: @rooms.map { |room| room.as_json.merge(images: room.images.map { |image| url_for(image) }) } }, status: :ok
    else
      render json: @rooms.errors, status: :bad_request
    end
  end

  # GET /api/v1/accommodations/1/rooms/1
  def show
    authorize @room

    render json: @room.as_json(include: :images).merge(
      images: @room.images.map do |image|
        url_for(image)
      end
    )
  end

  # POST /api/v1/rooms
  def create
    @room = @accommodation.rooms.new(room_params.except(:images))

    authorize @room

    build_images if params[:images].present?
    if @room.save
      render json: {
        data: {
          room: @room,
          image_urls: @room.images.map { |image| url_for(image) }
        }
      }, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/rooms/1
  def update
    build_images if params[:images].present?

    authorize @room

    if @room.update(room_params)
      render json: {
        data: {
          room: @room,
          image_urls: @room.images.map { |image| url_for(image) }
        }
      }, status: :ok
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/rooms/1
  def destroy
    authorize @room

    if @room.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find_by_id(params[:accommodation_id])
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def booked_room_ids(check_in, check_out)
    Booking.joins(:room)
           .where(check_in: ..check_out, check_out: check_in..)
           .pluck(:room_id)
  end

  def available_rooms
    @free_places = @accommodation.rooms.where.not(id: booked_room_ids(@check_in, @check_out))
                                 .pluck(:places).sum
    return unless @free_places >= @number_of_peoples.to_i

    @available_rooms = @accommodation.rooms.where.not(id: booked_room_ids(@check_in, @check_out))
  end

  def build_images
    params[:images].each do |img|
      @room.images.attach(io: img, filename: img.original_filename)
    end
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.permit(:places, :bed, :name, :quantity, :description, :price_per_night, images: [])
  end

  def authorize_policy
    authorize Room
  end
end
