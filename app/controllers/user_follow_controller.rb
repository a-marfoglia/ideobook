class UserFollowController < ApplicationController
  def new
    user = User.find(params[:id])
    if (!current_user.following?(user) && user != current_user)
      follow_obj = current_user.follow(user)
      create_notification(user, follow_obj)
    end
    redirect_to(user)
  end
  
  def destroy
    user = User.find(params[:id])
    current_user.stop_following(user) if current_user.following?(user) && user != current_user
    redirect_to(user)
  end
  
  private
  
    def create_notification (user, follow_obj)
      Notification.create(  user_id: user.id,
                            subscribed_user_id: current_user.id,
                            follow_id: follow_obj.id,
                            notice_type: 0
                         ) if user!= current_user
    end
end
