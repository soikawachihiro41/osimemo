# frozen_string_literal: true

class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  include Rails.application.routes.url_helpers

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        handle_message_event(event)
      when Line::Bot::Event::Postback
        handle_postback(event)
      end
    end
    head :ok
  end

  private

  def handle_message_event(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      if event.message['text'] == '何が出るかな...'
        send_random_photo_reply(event)
      elsif event.message['text'] == '写真を探すよ。撮影日を入力してね'
        send_date_picker(event['replyToken'])
      end
    end
  end

  def send_random_photo_reply(event)
    user = User.find_by(line_id: event['source']['userId'])
    idol_data = user.random_idol_with_photo

    if idol_data[:photo]
      image_url = idol_data[:photo].image.url
      show_url = url_for(controller: 'photos', action: 'show', id: idol_data[:photo].id)
      album_name = idol_data[:photo].album.name
      idol_name = idol_data[:photo].album.idol.name
      message = build_flex_message(image_url, album_name, idol_name, show_url)
    else
      message = {
        type: 'text',
        text: '機嫌が悪のかな? もう一度呼んでみて'
      }
    end
    client.reply_message(event['replyToken'], message)
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET_bot', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end

  def build_flex_message(image_url, album_name, idol_name, show_url)
    {
      type: 'flex',
      altText: 'This is a Flex Message',
      contents: {
        type: 'bubble',
        body: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: 'image',
              url: image_url,
              size: 'full',
              aspectMode: 'cover',
              aspectRatio: '1:1',
              gravity: 'center',
              action: {
                type: 'uri',
                label: 'View Details',
                uri: show_url
              }
            },
            {
              type: 'box',
              layout: 'horizontal',
              contents: [
                {
                  type: 'box',
                  layout: 'vertical',
                  contents: [
                    {
                      type: 'text',
                      size: 'xl',
                      color: '#ffffff',
                      text: album_name,
                      align: 'start'  # Left align
                    },
                    {
                      type: 'text',
                      text: idol_name,
                      color: '#ffffff',
                      size: 'md',
                      flex: 0,
                      align: 'start'  # Left align
                    }
                  ],
                  spacing: 'xs'
                }
              ],
              position: 'absolute',
              offsetBottom: '0px',
              offsetStart: '0px',
              offsetEnd: '0px',
              paddingAll: '20px'
            }
          ],
          paddingAll: '0px'
        }
      }
    }
  end

  def send_date_picker(reply_token)
    message = {
      type: 'template',
      altText: '日付を選択してください',
      template: {
        type: 'buttons',
        text: '日付を選択',
        actions: [
          {
            type: 'datetimepicker',
            label: '日付を選択',
            data: 'action=choose_date',
            mode: 'date'
          }
        ]
      }
    }
    client.reply_message(reply_token, message)
  end

  def handle_postback(event)
    capture_date_str = event['postback']['params']['date']
    capture_date = Date.strptime(capture_date_str, '%Y-%m-%d')

    line_id = event['source']['userId']
    user = User.find_by(line_id:)

    photos = Photo.joins(:album).where(albums: { user_id: user.id },
                                       capture_date: capture_date.all_day)

    if photos.any?
      selected_photos = photos.sample(4) # 4つまでの写真をランダムに選択

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
      # 撮影日に関連する写真がない場合のメッセージ
      no_photos_message = {
        type: 'text',
        text: "ごめんなさい💦 #{capture_date_str} の写真は見つからなかったよ。他の日で試してみてね🌸🌼"

      }
      client.reply_message(event['replyToken'], no_photos_message)
    end
  end
end
