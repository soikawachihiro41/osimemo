class SendPhotoJob < ApplicationJob
  queue_as :default

  def perform(time_period)
    # 指定時間帯のユーザーを取得
    users = User.joins(:notification_setting)
                .where(notification_settings: { preferred_time: time_period })
    
    users.find_each do |user|
      # ユーザーの選択したアイドルを取得
      idols = user.idols.includes(:albums).where(is_selected: true)

      # ランダムに1人選ぶ
      idol = idols.sample

      # そのアイドルのアルバムからランダムに1つ選ぶ
      album = idol.albums.sample

      # アルバムに紐づく写真からランダムに1枚取得
      photo = album.photos.sample

      # メッセージを構築
      message = build_message(photo)
      
      Rails.logger.info("Sending message to user #{user.id}")
      client.push_message(user.line_id, message)
      Rails.logger.info("Message sent to user #{user.id}")
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
