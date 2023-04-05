class Api::V1::SubscriptionsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[show create update]
  before_action :set_subscription, except: %i[create]

  def show
    render json: @subscription
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render json: { status: 'Create', data: @subscription }, status: :ok
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subscription.update(subscription_params)
      render json: { status: 'Update', data: @subscription }, status: :ok
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  private
  
  def set_subscription
    @subscription = Subscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'subscription id not found' }, status: :not_found
  end

  def subscription_params
    params.require(:data).permit(:card_number, :exp_month, :exp_year, :cvc, :user_id, :plan_id, :active)
  end
end
