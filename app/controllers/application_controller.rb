class ApplicationController < ActionController::API
  include Sorcery::Controller
  def form_authenticity_token; end

  before_action :authenticate

  def authenticate
    @user = User.find_by_api_token!(request.headers['X-Api-Key'])
  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  end

  def current_user
    @user
  end
end
