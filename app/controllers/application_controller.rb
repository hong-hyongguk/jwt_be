class ApplicationController < ActionController::API
  include ActionController::Cookies
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header_token = header.split(' ').last if header
    puts "header_token: #{header_token}"
    begin
      @decoded = JsonWebToken.decode(header_token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
