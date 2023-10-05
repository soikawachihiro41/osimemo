class UploadImageJob < ApplicationJob
  queue_as :default

  def perform(cached_file_identifier, photo_attributes, album_id, user_id, tag_list)
    uploader = CoverImageUploader.new
    uploader.retrieve_from_cache!(cached_file_identifier)
    uploader.store!

    # 画像のURLをphoto_attributesに追加
    photo_attributes[:image] = uploader.url
    
    # Photoモデルのインスタンスを作成し、保存
    photo = Photo.new(photo_attributes)
    photo.album_id = album_id
    photo.user_id = user_id

    if photo.save
      # タグの保存処理
      tag_list.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name.strip)
        PhotoTag.create(photo: photo, tag: tag)
      end
    else
      # エラーハンドリング（例：ログ出力）
      Rails.logger.error("Failed to save photo: #{photo.errors.full_messages.join(', ')}")
    end
  end
end
