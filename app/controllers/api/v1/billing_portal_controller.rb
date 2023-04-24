class Api::V1::BillingPortalController < ApplicationController
  skip_before_action :authenticate_request
  include ActionView::Layouts
  include ActionController::Rendering

  def create  
    portal_session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_id,
      return_url: root_url,
    })
    render json: { url: portal_session.url }
  end
end
