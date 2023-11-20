# frozen_string_literal: true

class CoverImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  # WebPへの変換
  process convert: 'webp'
  cloudinary_transformation width: 400, height: 400, crop: :thumb, gravity: :faces, quality: 'auto',
                            fetch_format: 'auto'

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*_args)
    ActionController::Base.helpers.asset_path('1.webp')
  end

  # 画像の拡張子を制限
  def extension_allowlist
    %w[jpg jpeg gif webp HEIC heic heif HEIF]
  end

  # 一意のファイル名を生成し、拡張子を.webpで保存
  def filename
    "#{secure_token}.webp" if original_filename
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
