class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  # Before-action to authorize the request
  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = decode_token(token)
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  private

  # Decode JWT token
  def decode_token(token)
    JWT.decode(token, SECRET_KEY)[0].with_indifferent_access
  end
end
