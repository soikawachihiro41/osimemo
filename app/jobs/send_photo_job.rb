class SendPhotoJob < ApplicationJob
  queue_as :default

  def perform(time_period)
    users = User.joins(:notification_setting)
                .where(notification_settings: { preferred_time: time_period })
    
    if users.empty?
      Rails.logger.info("No users found for time_period #{time_period}")
      return
    end
  
    users.find_each do |user|
      idols = user.idols.includes(:albums).where(is_selected: true)
  
      if idols.empty?
        Rails.logger.info("No selected idols for user #{user.id}")
        next
      end
  
      idol = idols.sample
      album = idol.albums.sample
  
      if album.nil?
        Rails.logger.info("No albums found for idol #{idol.id}")
        next
      end
  
      photo = album.photos.sample
  
      if photo.nil?
        Rails.logger.info("No photos found for album #{album.id}")
        next
      end
  
      message = build_message(photo)
      response = client.push_message(user.line_id, message)
  
      # APIからのレスポンスをログに出力
      Rails.logger.info("API Response: #{response}")
    end
  end
  

  private

  def build_message(photo)
    if photo
      {
        type: 'image',
        originalContentUrl: photo.image.url,
        previewImageUrl: photo.image.url  
      }
    else
      {
        type: 'text', 
        text: '写真がありません'  
      }
    end
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
