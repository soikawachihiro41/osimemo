# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :album
  belongs_to :uploader, class_name: 'User'
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  mount_uploader :image, CoverImageUploader
  attr_accessor :overlay, :x_offset, :y_offset, :width, :height
  # validate :image_size_validation
  attr_accessor :image_secure_token

  attr_accessor :tag_names

  validates :image, presence: true
  validates :capture_date, presence: true
  validates :body, length: { maximum: 800 }

  def self.generate_composite_image_url(user_photo_public_id, heart_overlay_public_id = "bdae9b71a0f463997c342fb282c57426_t_utgw9l", x_offset = 0, y_offset = 0)
    Cloudinary::Utils.cloudinary_url(user_photo_public_id, 
      transformation: [
        { width: 500, height: 500, crop: :fill },
        { overlay: heart_overlay_public_id, width: 100, height: 100, x: x_offset, y: y_offset, gravity: :north_west }
      ]
    )
  end

  def viewable_or_editable_by?(user)
    uploader_id == user.id
  end

  def self.create_with_tags(album, attributes, uploader)
    album.photos.new(attributes.except(:tag_names).merge(uploader:))
  end

  def update_photo_and_tags(attributes, tag_list = [])
    assign_attributes(attributes)
    if valid?
      save_tags(tag_list)
      save
    else
      false
    end
  end

  def save_tags(sent_tags)
    sent_tags ||= []
    current_tags = tags.pluck(:tag_names) || []

    remove_old_tags(current_tags - sent_tags)
    add_new_tags(sent_tags - current_tags)
  end

  def remove_old_tags(old_tags)
    old_tags.each do |tag_name|
      tag = Tag.find_by(tag_names: tag_name)
      photo_tags.where(tag_id: tag.id).destroy_all
    end
  end

  def add_new_tags(new_tags)
    new_tags.each do |tag_name|
      tag = Tag.find_or_create_by(tag_names: tag_name)
      photo_tags.build(tag_id: tag.id)
    end
  end

  private

  def details
    {
      image_url: image.url,
      album_name: album.name,
      idol_name: album.idol.name
    }
  end
end
