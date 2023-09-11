class Photo < ApplicationRecord
  belongs_to :album
  belongs_to :uploader, class_name: 'User', foreign_key: 'uploader_id'
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  mount_uploader :image, CoverImageUploader
  validates :image, file_size: { less_than_or_equal_to: 400.kilobytes }
  attr_accessor :tag_names
  after_save :process_image

  validates :image, presence: true
  validates :album_id, presence: true
  validates :capture_date, presence: true

  after_save :process_image
  
  def process_image
    return unless image_path.present?
  
    temp_dir = Dir.mktmpdir('image_processing')
  
    begin
      original_image_path = Rails.root.join('path', 'to', 'storage', image_path)
  
      processed_image_path = File.join(temp_dir, 'processed_image.jpg')
        
      image = MiniMagick::Image.open(original_image_path)
      image.resize '800x600'
      image.write processed_image_path
        
        # ここでさらなる処理を行ったり、processed_image_pathを永続ストレージに保存したりします。
        
    ensure
        # 使用後に一時ディレクトリを削除
      FileUtils.remove_entry temp_dir
    end
  end

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
