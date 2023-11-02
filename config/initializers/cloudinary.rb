# frozen_string_literal: true

Cloudinary.config do |config|
  config.cloud_name = ENV.fetch('CLOUDINARY_CLOUD_NAME', nil)
  config.api_key = ENV.fetch('CLOUDINARY_API_KEY', nil)
  config.api_secret = ENV.fetch('CLOUDINARY_API_SECRET', nil)
  config.secure = true
  config.cdn_subdomain = true
end
