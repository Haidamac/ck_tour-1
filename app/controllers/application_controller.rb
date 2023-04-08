class ApplicationController < ActionController::API
  include JsonWebToken
  include Authenticate
  include Pundit::Authorization

  before_action :authenticate_request

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Stripe::CardError, with: :stripe_card_error

  private

  def authenticate_request
    header = request.headers['Authorization']
    if header.present? && header.split(' ').first == 'Bearer'
      token = header.split(' ').last
      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def pundit_user
    @current_user
  end

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
  end

  def render_success(data:, status: :ok)
    render json: { data: }, status:
  end
end
