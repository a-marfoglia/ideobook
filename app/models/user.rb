class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  acts_as_follower
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: { maximum: 31 }  
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
  
  def favourite_category
    counting = Hash.new
    # Counts all the categories
    self.microposts.each do |micropost|
      counting[micropost.category_id] ||= 1
      counting[micropost.category_id] += 1
    end

    favourite_category_key = 0
    counting.each do |key, value|
      highest ||= value
      favourite_category_key =  favourite_category_key == 0 ? key : favourite_category_key
      favourite_category_key = value > highest ? key : favourite_category_key
    end
    return nil if favourite_category_key == 0
    favourite_category_key
  end
  
  
end
