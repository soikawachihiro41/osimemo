# # frozen_string_literal: true

# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/fog'

# # config/initializers/carrierwave.rb
# CarrierWave.configure do |config|
#   if Rails.env.production? || Rails.env.staging? # 本番環境またはステージング環境の場合
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: ENV['S3_ACCESS_KEY'],
#       aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
#       region: 'ap-northeast-1' # 必要に応じて変更してください
#     }
#     config.fog_directory  = ENV['S3_BUCKET_NAME']
#     config.fog_public     = false # オプション（publicでない場合は、リンクは期限付きになります）
#     config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
#   else
#     config.storage = :file # 開発環境やテスト環境の場合
#     config.enable_processing = false if Rails.env.test?
#   end

#   # Cloudinaryの設定
#   if Rails.env.production?
#     config.cloudinary_credentials = {
#       cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
#       api_key: ENV['CLOUDINARY_API_KEY'],
#       api_secret: ENV['CLOUDINARY_API_SECRET']
#     }
#   end
# end
