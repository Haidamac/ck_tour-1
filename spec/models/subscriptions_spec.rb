require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/subscriptions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/subscriptions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/subscriptions/update"
      expect(response).to have_http_status(:success)
    end
  end

end
