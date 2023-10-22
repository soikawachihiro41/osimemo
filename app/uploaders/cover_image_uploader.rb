# app/uploaders/cover_image_uploader.rb
require 'open-uri'
require 'uri'

class CoverImageUploader < CarrierWave::Uploader::Base
  #include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  # Cloudinaryでの加工
  version :face_centered do
    process :convert_to_webp_and_resize
    cloudinary_transformation format: 'webp', width: 400, height: 400, crop: :thumb, gravity: :face
  end

  # Choose what kind of storage to use for this uploader:
    #storage :file
    storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'no_image_gray.png'
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_allowlist
    %w[jpg jpeg gif png HEIC heic heif HEIF webp]
  end

  # Override the filename of the uploaded files:
  def filename
    original_filename.present? ? "#{secure_token}.#{file.extension}" : nil
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

  private

  # S3へのアップロードを行うafter_storeコールバック
  after :store, :upload_to_s3

  def upload_to_s3(file)
    uploaded_file = file
    cloudinary_url = url
    s3_object_key = "#{store_dir}/#{uploaded_file.filename}" if uploaded_file.present?
  
    begin
      URI.open(cloudinary_url) do |image|
        uploader = CarrierWave::Storage::Fog::File.new(self, CarrierWave::Storage::Fog.new(self), s3_object_key)
        uploader.store(image)
      end
  
      model.update(image_url: uploader.url) # `image_url`はS3のパスを保存するための属性です
    rescue OpenURI::HTTPError => e
      Rails.logger.error "Cannot retrieve file from Cloudinary URL #{cloudinary_url}: #{e.message}"
      # ここで適切なエラー処理を実装します。例えば、エラーをユーザーに通知したり、リトライロジックを追加したりすることができます。
    end
  end
  
end
