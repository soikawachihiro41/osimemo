class PhotoTag < ApplicationRecord
  belongs_to :photo
  belongs_to :tag

  validates :photo_id, presence: true
  validates :tag_id, presence: true
end
