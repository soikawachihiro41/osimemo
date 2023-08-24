# app/jobs/send_photo_job.rb
class SendPhotoJob < ApplicationJob
  queue_as :default

  def perform(time_period)
    users = User.where(preferred_time: time_period)

    users.each do |user|
      photo = Photo.order("RANDOM()").first  # ランダムな写真を選ぶロジック
      user_id = user.line_user_id # ユーザーがLINEで使っているID
      
      # LINE APIクライアントの設定
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }

      # 画像を送信するためのメッセージオブジェクト
      message = {
        type: 'image',
        originalContentUrl: photo.url, # 画像のURL
        previewImageUrl: photo.preview_url # 画像のプレビューURL
      }

      # LINE APIを使って写真を送る
      client.push_message(user_id, message)
    end
  end
end
