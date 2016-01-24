class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation)
  end
  
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end

  def after_sign_up_path_for(resource)
    "/home"
  end

  def after_inactive_sign_up_path_for(resource)
    "/users/signup"
  end

end