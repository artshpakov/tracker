class AuthController < ApplicationController
  skip_before_action :authenticate, only: :auth

  def me
    render json: authenticate.slice(*public_user_fields)
  end

  def auth
    if user = User.authenticate(params[:email], params[:password])
      render json: user.slice(*public_user_fields), status: :ok
    else
      render json: {error: "Invalid credntials"}, status: :unauthorized
    end
  end


  protected

  def public_user_fields
    %w(id email api_token)
  end
end
