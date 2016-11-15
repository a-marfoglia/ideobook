class AvatarUploadsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(upload_params)
      redirect_to @user
    else
      flash.alert = "Sono supportate solamente immagini nei formati *.jpeg, *jpg, *.png, *.gif e inferiori a un peso di 5MB."
      redirect_to @user
    end
  end

  private
    def upload_params
      params.require(:user).permit(:avatar)
    end
end
