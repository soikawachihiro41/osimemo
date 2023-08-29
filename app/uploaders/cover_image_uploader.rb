class CoverImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # 画像リサイズ（800x800に合わせる）
  process resize_to_fit: [800, 800]

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # 画像の拡張子を制限
  def extension_allowlist
    %w(jpg jpeg gif png)
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
end
