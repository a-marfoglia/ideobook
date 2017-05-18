class EditTypeToNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :type, :notice_type
  end
end
