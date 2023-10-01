# frozen_string_literal: true

# app/services/send_photo_service.rb

class SendPhotoService
  def initialize(user)
    @user = user
    @client = initialize_client
  end

  def perform
    random_resources = @user.random_idol_with_photo
    return unless valid_resources?(random_resources)

    send_photo(random_resources[:photo])
  end

  private

  def valid_resources?(resources)
    return true if resources.values.all?

    log_resource_error(resources)
    false
  end

  def log_resource_error(resources)
    Rails.logger.info("No selected idols for user #{@user.id}") unless resources[:idol]
    Rails.logger.info("No albums found for idol #{resources[:idol]&.id}") unless resources[:album]
    Rails.logger.info("No photos found for album #{resources[:album]&.id}") unless resources[:photo]
  end

  def send_photo(photo)
    message = FlexMessageBuilderService.new(photo).build
    response = @client.push_message(@user.line_id, message)
    Rails.logger.info("API Response: #{response}")
  end

  def initialize_client
    Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET_bot', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end
end
