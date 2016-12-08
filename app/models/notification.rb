class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribed_user
  belongs_to :micropost
  belongs_to :comment
  
  validates :user_id, :subscribed_user_id, :notice_type, presence: true
end
