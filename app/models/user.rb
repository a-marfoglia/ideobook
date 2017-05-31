class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  acts_as_follower
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true, length: { maximum: 20, minimum: 6 }
  before_save { email.downcase! }

  def notifications_num
    self.notifications.where(read: nil).count
  end

  def has_new_notifications?
    (self.notifications_num > 0)
  end

  def last_notifications(num)
    self.notifications.first(num) if num > 0
  end

end
