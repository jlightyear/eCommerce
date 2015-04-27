class RegistrationsController < Devise::RegistrationsController

  private

  def sing_up_params
    params.require(:usuario).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:usuario).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :current_password)
  end

end