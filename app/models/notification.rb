class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribed_user, class_name: 'User'
  belongs_to :micropost
  belongs_to :comment
  default_scope -> { order(created_at: :desc) }
  validates :user_id, :subscribed_user_id, :notice_type, presence: true
  
  def to_s
    if    self.notice_type == 0
      "#{self.subscribed_user.username} ti sta seguendo!"
    elsif self.notice_type == 1
      "#{self.subscribed_user.username} ha messo mi piace al tuo post!"
    elsif self.notice_type == 2
      "#{self.subscribed_user.username} ha commentato questo post!"
    end
  end
end
