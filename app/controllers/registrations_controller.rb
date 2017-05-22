class RegistrationsController < Devise::RegistrationsController

  def destroy
    resource.destroy
    set_flash_message :notice, :destroyed
    sign_out_and_redirect(self.resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :birth_date, :occupation, :password, :password_confirmation, :current_password)
  end

end
