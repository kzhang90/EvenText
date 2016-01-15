class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    @user = User.new
    respond_with @user, :location => root_path
  end
  

  private

  def sign_up_params
    params.require(:user).permit(:name, :phone_number, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :phone_nubmer, :email, :password, :password_confirmation, :current_password)
  end
  
end