class AddFollowToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :follow, index: true, foreign_key: true
  end
end
