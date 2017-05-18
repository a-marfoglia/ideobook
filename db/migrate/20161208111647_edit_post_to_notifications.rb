class EditPostToNotifications < ActiveRecord::Migration
  def change
    remove_reference :notifications, :post
    add_reference :notifications, :micropost, index: true, foreign_key: true
  end
end
