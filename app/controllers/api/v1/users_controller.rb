class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: %i[show destroy create_admin change_role]
  before_action :authorize_policy

  # GET api/v1/users
  def index
    @users = User.all

    authorize @users

    render json: @users, status: :ok
  end

  # GET api/v1/users/{name}
  def show
    authorize @user

    render json: @user, status: :ok
  end

  # POST api/v1/users
  def create
    @user = User.new(user_params)

    authorize @user

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT api/v1/users/{name}
  def update
    authorize @user

    if user&.authenticate(params[:current_password])
      user.update(password: params[:new_password])
      render json: { message: 'Password updated successfully' }, status: :ok
    else
      render json: { error: 'Invalid current password' }, status: :unprocessable_entity
    end
    # unless @user.update(user_params)
    #   render json: { errors: @user.errors.full_messages },
    #          status: :unprocessable_entity
    # end
  end

  # DELETE api/v1/users/{name}
  def destroy
    authorize @user

    @user.destroy
  end

  def create_admin
    authorize @user

    @user.admin!
  end

  def change_role
    authorize @user

    if @user.tourist?
      @user.partner!
    else
      @user.tourist!
      @user.accommodations.destroy_all
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_policy
    authorize User
  end
end
