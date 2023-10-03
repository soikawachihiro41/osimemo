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
  def default_url(*_args)
    '/assets/default-profile-image.jpg'
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
    %w[jpg jpeg gif png HEIC heic heif HEIF]
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

# HEIC/HEIFをJPEGに変換
  process :convert_heic_to_jpeg

  def convert_heic_to_jpeg
    if file.extension.downcase == 'heic' || file.extension.downcase == 'heif'
      manipulate! do |img|
        img.format('jpeg') do |c|
          c.quality '40' # 変換後のJPEGの品質を設定
        end
        img
      end
    end
  end

# JPEGの最適化
  process :optimize_jpeg

  def optimize_jpeg
    manipulate! do |img|
      img.format('jpeg') do |c|
        c.quality '40' # 60の品質に設定。適宜調整可能。
      end
      img
    end
  end

  process :compress_png

  def compress_png
    manipulate! do |img|
      img.format('png') do |c|
        c.colors '16' # 8ビットカラーに変換
      end
      img
    end
  end

  def compress_with_pngquant
    manipulate! do |img|
      img.write(current_path)
      `pngquant --quality=0-50 --ext .png --force #{current_path}`
      img
    end
  end
end
