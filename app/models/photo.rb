# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :album
  belongs_to :uploader, class_name: 'User'
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  mount_uploader :image, CoverImageUploader

  # validate :image_size_validation

  attr_accessor :tag_names

  validates :image, presence: true
  validates :capture_date, presence: true
  validates :body, length: { maximum: 800 }

  def viewable_or_editable_by?(user)
    uploader_id == user.id
  end

  def self.create_with_tags(album, attributes, uploader)
    album.photos.new(attributes.except(:tag_names).merge(uploader: uploader))
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
      photo_tags.create(tag_id: tag.id)
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
