class RegistrationController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  def after_sign_up_path_for(resource)
    register_user_address_users_path
  end

end
