class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 6 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png video/mpeg video/mp4 video/quicktime video/webm image/tiff image/x-icon image/svg+xml audio/mpeg audio/x-wav application/pdf application/xml application/zip],
                                      message: "must be a valid image format" },
                      size:         { less_than: 150.megabytes,
                                      message:   "should be less than 150MB" }

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end                                      

end
