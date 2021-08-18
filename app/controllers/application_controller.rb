class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :user_auth_params, if: :devise_controller?

  private

  def user_auth_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :icon_color, :introduce])
  end
end
