# frozen_string_literal: true

class CoverImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # 一意のファイル名を生成
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

  # デフォルトのURL
  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, "no_image_gray.png"].compact.join('_'))
  end

  # 顔を中心にしたサムネイルバージョン
  version :face_centered do
    process convert: 'webp' # 画像形式の変換
    cloudinary_transformation width: 300, height: 300, crop: :thumb, gravity: :face, angle: :auto # リサイズ、顔中心、回転制御の設定
  end

  # 許可される画像の拡張子
  def extension_allowlist
    %w[jpg jpeg gif png HEIC heic heif HEIF webp]
  end
end

