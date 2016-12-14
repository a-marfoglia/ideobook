class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @notification = Notification.find(params[:id])
    @notification.update_attribute(:read, true)
    if    @notification.notice_type == 0
      redirect_to user_path(@notification.subscribed_user_id)
    elsif @notification.notice_type == 1
      redirect_to micropost_path(@notification.micropost_id)
    elsif @notification.notice_type == 2
      redirect_to micropost_path(@notification.micropost_id)
    end
  end

  def index
    @notifications = Notification.paginate(params[:page], per_page: 20)
  end
end
