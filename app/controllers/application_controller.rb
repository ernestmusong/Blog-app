class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  def after_sign_up_path_for(_resource)
    user_session_path
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:photo, :name, :email, :bio, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:photo, :name, :email, :bio, :password, :current_password)
    end
  end
end
