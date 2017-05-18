class MicropostFollowController < ApplicationController
  def new
    micropost = Micropost.find(params[:id])
    if (!current_user.following?(micropost) && micropost.user != current_user)
      follow_obj = current_user.follow(micropost)
      create_notification(micropost, follow_obj)
    end
    redirect_to(micropost)
  end
  
  def destroy
    micropost = Micropost.find(params[:id])
    current_user.stop_following(micropost) if current_user.following?(micropost) && micropost.user != current_user
    redirect_to(micropost)
  end
  
  private
      def create_notification (micropost, follow_obj)
        Notification.create(  user_id: micropost.user.id,
                            subscribed_user_id: current_user.id,
                            follow_id: follow_obj.id,
                            micropost_id: micropost.id,
                            notice_type: 1
                           ) if micropost.user!= current_user
    end
end
