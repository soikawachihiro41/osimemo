# frozen_string_literal: true

class CoverImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # 画像リサイズ（800x800に合わせる）
  # process resize_to_fit: [400, 400]

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'no_image_gray.png'
  end

  process scale: [400, 400]
  def scale(width, height)
    manipulate! do |img|
      Rails.logger.debug { "Image path before resizing: #{img.path}" }
      img.resize "#{width}x#{height}!"
      Rails.logger.debug { "Image path after resizing: #{img.path}" }
      img
    rescue StandardError => e
      Rails.logger.error "An error occurred: #{e.message}"
      raise e
    end
  end

  # 画像の拡張子を制限
  def extension_allowlist
    %w[jpg jpeg gif png HEIC heic heif HEIF webp]
  end

  # 一意のファイル名を生成
  def filename
    "#{secure_token}.#{file.extension}" if original_filename
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

#🔥WebPに変換
  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format 'webp'
      img
    end
  end
  #🔥拡張子を.webpで保存
  def filename
    super.chomp(File.extname(super)) + '.webp' if original_filename.present?
  end
end
