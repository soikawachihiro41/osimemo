class SendPhotoJob < ApplicationJob
  queue_as :default

  def perform(time_period)
    # ユーザーの設定（notification_settings）に基づいて
    # どのユーザーに写真を送るかを判定
    users = User.joins(:notification_settings)
                .where(notification_settings: { time_period: time_period })

    users.each do |user|
      idol = user.idols.where(is_selected: true).first
      photo = idol.photos.order("RANDOM()").first if idol
      
      # LINE APIで写真を送る（以下は例として、具体的な実装はプロジェクトに応じて）
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
      message = {
        type: 'image',
        originalContentUrl: photo.image_url,
        previewImageUrl: photo.image_url
      }
      client.push_message(user.line_id, message)
    end
  end
end
