class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  acts_as_follower
  has_many :microposts
  has_many :comments
  has_many :notifications, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: { maximum: 31 }
  before_save { email.downcase! }
  
  def notifications_num
    self.notifications.where(read: nil).count
  end
  
  def last_notifies(num)
    self.notifications.first(num) if num > 0
  end
end
