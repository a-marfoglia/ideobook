class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit, :delete]
  #TODO: correct_user

  def show
    @notification = Notification.find(params[:id])
    set_read(@notification)
    switch_notification(@notification)
  end

  def index
    @notifications = Notification.paginate(page: params[:page],
                      per_page: 20).where(user_id: current_user.id)
  end

  def edit
    @notification = Notification.find(params[:id])
    set_read(@notification)
    redirect_to notifications_path(page: params[:page])
  end

  private
    def set_read(notification)
      notification.update_attribute(:read, true) if !notification.read
    end

    def switch_notification(notification)
      if    notification.notice_type == 0
        redirect_to user_path(notification.subscribed_user_id)
      elsif notification.notice_type == 1
        redirect_to micropost_path(notification.micropost_id)
      elsif notification.notice_type == 2
        redirect_to micropost_path(notification.micropost_id)
      end
    end
end
