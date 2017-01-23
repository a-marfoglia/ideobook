class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #default_scope -> { order(views: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 300 }
  validates :category_id, presence: true

  mount_uploader :attachment, AttachmentUploader
  validate  :attachment_size

  acts_as_followable


  def self.search(search,category,read,like)
    if search
      joins(:user).where(["microposts.title LIKE ? OR users.username LIKE ?","%#{search}%","%#{search}%"]).order(created_at: :desc)
    elsif category
        where(["category_id LIKE ?","%#{category}%"]).order(created_at: :desc)
    elsif read
        order(views: :desc)
    elsif like
    else
       order(created_at: :desc)
    end
  end

  def increment_views
    self.increment :views
    self.save
  end

  def self.top5
=begin
    ActiveRecord::Base.connection.exec_query("\
      SELECT users.id AS user_id, microposts.id AS micropost_id,\
             microposts.title, COUNT(*) AS num FROM microposts\
      JOIN follows ON follows.followable_id = microposts.id\
      JOIN users ON users.id = microposts.user_id\
      WHERE follows.followable_type = 'Micropost'\
      GROUP BY microposts.id\
      ORDER BY num DESC\
      LIMIT 5")
=end
    Micropost.select("*", "COUNT(follows.followable_id) as num")
    .joins("LEFT JOIN follows ON follows.followable_id = microposts.id")
    .where("follows.followable_type = 'Micropost' OR follows.followable_type IS NULL")
    .group("microposts.id")
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
