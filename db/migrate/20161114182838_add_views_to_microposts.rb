class AddViewsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :views, :int, default: 0
  end
end
