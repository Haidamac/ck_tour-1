class Api::V1::PlansController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_plan, except: %i[index create]

  def index
    @plans = Plan.all
    
    if @plans
      render json: { data: @plans }, status: :ok
    else
      render json: @plans.errors, status: :bad_request
    end
  end

  def show
    render json: @plan
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      render json: { status: 'Create', data: @plan }, status: :ok
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  def update
    if @plan.update(plan_params)
      render json: { status: 'Update', data: @plan }, status: :ok
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @plan.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'plan id not found' }, status: :not_found
  end

  def plan_params
    params.require(:plan).permit(:name, :description, :interval, :interval_count, :price_cents)
  end
end
