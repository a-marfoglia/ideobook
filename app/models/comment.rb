class Comment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 200 }
end
