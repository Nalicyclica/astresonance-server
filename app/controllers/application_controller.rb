class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :basic_auth
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :user_auth_params, if: :devise_controller?

  private

  def user_auth_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :icon_color, :introduce])
    devise_parameter_sanitizer.permit(:account_update, keys: [:icon_color, :introduce])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ASTRESONANCE_AUTH_USER'] && password == ENV['ASTRESONANCE_AUTH_PASSWORD']
    end
  end
end
