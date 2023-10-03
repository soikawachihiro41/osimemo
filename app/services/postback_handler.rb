# frozen_string_literal: true

class PostbackHandler
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::PolymorphicRoutes

  MAX_PHOTOS = 4 # 必要な場合は定数を設定

  def initialize(event, client)
    @event = event
    @client = client
  end

  def handle
    if photos.any?
      @client.reply_message(@event['replyToken'], build_photo_messages)
    else
      @client.reply_message(@event['replyToken'], no_photos_message)
    end
  end

  private

  def capture_date_str
    @capture_date_str ||= @event['postback']['params']['date']
  end

  def capture_date
    @capture_date ||= Date.strptime(capture_date_str, '%Y-%m-%d')
  end

  def user
    @user ||= User.find_by(line_id: @event['source']['userId'])
  end

  def photos
    @photos ||= user.photos_on_date(capture_date)
  end

  def build_photo_messages
    messages = photos.sample(MAX_PHOTOS).map do |photo|
      build_flex_message_for(photo)
    end
    messages.unshift(additional_photo_message)
    messages
  end

  def build_flex_message_for(photo)
    image_url = photo.image.url
    show_url = url_for(controller: 'photos', action: 'show', id: photo.id)
    album_name = photo.album.name
    idol_name = photo.album.idol.name
    FlexMessageBuilder.build(image_url, album_name, idol_name, show_url)
  end

  def additional_photo_message
    {
      type: 'text',
      text: "#{capture_date_str} の思い出をお届けしたよ"
    }
  end

  def no_photos_message
    {
      type: 'text',
      text: "ごめんなさい💦 #{capture_date_str} の写真は見つからなかったよ。他の日で試してみてね🌸🌼"
    }
  end
end
