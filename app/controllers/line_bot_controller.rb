class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # ユーザーからのメッセージが '1' かどうかを確認
          if event.message['text'] == '1'
            photo = Photo.where(album_id: 1).order("RANDOM()").first
            if photo
              image_url = photo.image.url # CarrierWave + Fogを使用している場合、これはS3のURLになる
        
            # ログに出力
              puts "Fetched image URL: #{image_url}"
        
              message = {
                type: 'image',
                originalContentUrl: image_url,
                previewImageUrl: image_url
              }
              client.reply_message(event['replyToken'], message)
            else
              # 画像が見つからなかった場合の処理
              message = {
                type: 'text',
                text: '画像を登録してね'
              }
            end
            client.reply_message(event['replyToken'], message)
          end
        end
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  def fetch_image_from_database
    # 仮にalbum_idが1のものを取得するとする
    photo = Photo.find_by(album_id: 1)
  
    if photo
      # 仮に画像がAWS S3や他のストレージに保存されているURLを返すとする
      return photo.image
    else
      # 画像が見つからない場合の処理
      return "https://example.com/image_not_found.jpg"
    end
  end  
end
