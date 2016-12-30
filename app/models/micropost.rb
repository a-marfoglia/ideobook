class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :notifications, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 300 }
  validates :category_id, presence: true

  mount_uploader :attachment, AttachmentUploader
  validate  :attachment_size
  
  acts_as_followable
  
  def self.search(search)
    if search
      where(["title LIKE ?","%#{search}%"])
    else
      all
    end
  end
      
  def increment_views
    self.increment :views
    self.save
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
