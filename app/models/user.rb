class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :microposts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: { maximum: 31 }
  before_save { email.downcase! }
end
