require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  let(:user_attributes) { {email: build(:regular).email, password: "secret"} }
  before { create(:regular, user_attributes) }

  context 'POST #auth' do
    it "authenticates user with valid credentials" do
      post :auth, params: {email: user_attributes[:email], password: user_attributes[:password]}
      expect(response).to have_http_status(:success)
    end

    it "rejects invalid credentials" do
      post :auth, params: {email: user_attributes[:email], password: "invalid"}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'API token validation' do
    let(:regular) { create :regular }

    it "is passed for an authenticated user" do
      @request.headers['X-Api-Key'] = regular.api_token
      get :me
      expect(response).to have_http_status(:success)
    end

    it "returns `unauthorized` if no token is present" do
      get :me
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns `unauthorized` for invalid token" do
      @request.headers['X-Api-Key'] = "invalid"
      get :me
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
