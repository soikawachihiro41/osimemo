class Photo < ApplicationRecord
  belongs_to :album
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  mount_uploader :image, CoverImageUploader
  attr_accessor :tag_names

  validates :image, presence: true
  validates :album_id, presence: true
  validates :capture_date, presence: true

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:tag_names) || []
    sent_tags ||= []

    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      tag = Tag.find_by(tag_names: old)
      photo_tag = self.photo_tags.find_by(tag_id: tag.id)
      photo_tag&.destroy
    end
    
    new_tags.each do |new|
      tag = Tag.find_or_create_by(tag_names: new)
      self.photo_tags.create(tag: tag)
    end
  end
end
