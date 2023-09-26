# frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory = ENV.fetch('S3_BUCKET_NAME', nil)
  config.fog_public = true
  config.cache_storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV.fetch('S3_ACCESS_KEY', nil),
    aws_secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY', nil),
    region: 'ap-northeast-1',
    path_style: true
  }
end
