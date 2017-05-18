class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #default_scope -> { order(views: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 300, mininum: 30 }
  validates :category_id, presence: true

  mount_uploader :attachment, AttachmentUploader
  validate  :attachment_size

  acts_as_followable


  def self.search(search,category,read,like)
    if search
      joins(:user).where(["microposts.title LIKE ? OR users.username LIKE ?","%#{search}%","%#{search}%"]).order(created_at: :desc)
    elsif category
      where(["category_id = ?","#{category}"]).order(created_at: :desc)
    elsif read
      order(views: :desc)
    elsif like
      select("microposts.id", "microposts.title", "microposts.user_id",
             "microposts.content", "microposts.views", "microposts.created_at",
             "COUNT(follows.followable_id) as num")
      .joins("LEFT JOIN follows ON follows.followable_id = microposts.id")
      .where("follows.followable_type = 'Micropost' OR follows.followable_type IS NULL")
      .group("microposts.id")
      .order("num DESC")
    else
      order(created_at: :desc)
    end
  end

  def increment_views
    self.increment :views
    self.save
  end

  def self.top5
    Micropost.select("microposts.id, microposts.title, microposts.user_id", "COUNT(follows.followable_id) as num")
    .joins("LEFT JOIN follows ON follows.followable_id = microposts.id")
    .where("follows.followable_type = 'Micropost' OR follows.followable_type IS NULL")
    .group("microposts.id,follows.id")
    .order("num DESC")
    .limit(5)
  end


  def has_attachment?
    !self.attachment.file.nil?
  end

  private
    # Validates the size of an uploaded attachment.
    def attachment_size
      if attachment.size > 5.megabytes
        errors.add(:attachment, "non dovrebbe essere più grande di 5MB")
      end
    end
end
