class MicropostFollowController < ApplicationController
  def new
    micropost = Micropost.find(params[:id])
    current_user.follow(micropost) unless current_user.following?(micropost) && micropost.user != current_user
    redirect_to(micropost)
  end
  
  def destroy
    micropost = Micropost.find(params[:id])
    current_user.stop_following(micropost) unless !current_user.following?(micropost) && micropost.user != current_user
    redirect_to(micropost)
  end
end
