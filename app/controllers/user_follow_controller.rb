class UserFollowController < ApplicationController
  def new
    user = User.find(params[:id])
    current_user.follow(user) unless current_user.following?(user) && user != currrent_user
    redirect_to(user)
  end
  
  def destroy
    user = User.find(params[:id])
    current_user.stop_following(user) unless !current_user.following?(user) && user != currrent_user
    redirect_to(user)
  end
end
