class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
end
