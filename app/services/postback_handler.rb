# frozen_string_literal: true

class PostbackHandler
  def initialize(event)
    @event = event
  end

  def handle
    capture_date_str = event['postback']['params']['date']
    capture_date = Date.strptime(capture_date_str, '%Y-%m-%d')

    line_id = event['source']['userId']
    user = User.find_by(line_id:) # line_id の指定を修正

    photos = user.photos_on_date(capture_date)

    if photos.any?
      selected_photos = photos.sample(MAX_PHOTOS) # 定数を使用して4を置き換える

      messages = selected_photos.map do |photo|
        image_url = photo.image.url
        show_url = url_for(controller: 'photos', action: 'show', id: photo.id)
        album_name = photo.album.name
        idol_name = photo.album.idol.name
        build_flex_message(image_url, album_name, idol_name, show_url)
      end

      additional_message = {
        type: 'text',
        text: "#{capture_date_str} の思い出をお届けしたよ"
      }
      messages.unshift(additional_message)

      Rails.logger.debug 'Before reply_message'
      client.reply_message(event['replyToken'], messages)
      Rails.logger.debug 'After reply_message'
    else
      no_photos_message = {
        type: 'text',
        text: "ごめんなさい💦 #{capture_date_str} の写真は見つからなかったよ。他の日で試してみてね🌸🌼"
      }
      client.reply_message(event['replyToken'], no_photos_message)
    end
  end
end
