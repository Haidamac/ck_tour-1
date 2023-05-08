module Userable
  extend ActiveSupport::Concern

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.current.utc
    save!(validate: false)
  end

  def password_token_valid?
    (reset_password_sent_at + PASSWORD_RESET_EXPIRATION) > Time.current.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!(validate: false)
  end

  def ensure_stripe_customer
    response = Stripe::Customer.create(email:)
    self.stripe_id = response.id
  end

  # to retrieve all the Stripe info for user
  def retrieve_stripe_reference
    Stripe::Customer.retrieve(stripe_id)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
