class Album < ApplicationRecord
  belongs_to :user
  belongs_to :idol
  has_many :photos, dependent: :destroy
  mount_uploader :cover_image, CoverImageUploader

  validates :name, presence: true
  validates :cover_image, presence: true
  validates :user_id, presence: true
  validates :idol_id, presence: true
end
