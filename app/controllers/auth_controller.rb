class AuthController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(auth_params[:email])
    if @user&.authenticate(auth_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.name }, status: :ok

    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
