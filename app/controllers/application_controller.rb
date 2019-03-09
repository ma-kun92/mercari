class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :sign_in_required
private
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_phonetic, :first_name_phonetic, :birth_year, :birth_month, :birth_day])
  end
  def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
  end
end
