require 'carrierwave/storage/abstract'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory = ENV['S3_BUCKET_NAME']
  config.fog_public = true
  config.cache_storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_ACCESS_KEY'],
    aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1',
    path_style: true
  }
end
