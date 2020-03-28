class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  protected

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def authenticate_user
    if @current_user == nil

    redirect_to("/login")

    end
  end
end
