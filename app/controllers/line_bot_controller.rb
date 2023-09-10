class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  include Rails.application.routes.url_helpers

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
          if event.message['text'] == '何が出るかな...'
            user = User.find_by(line_id: event['source']['userId'])
            idol = user.idols.includes(:albums).where(is_selected: true).sample
            album = idol&.albums&.sample
            photo = album&.photos&.sample
            if photo
              image_url = photo.image.url
              show_url = url_for(controller: 'photos', action: 'show', id: photo.id)
              album_name = photo.album.name
              idol_name = photo.album.idol.name
              message = build_flex_message(image_url, album_name, idol_name, show_url)
              client.reply_message(event['replyToken'], message)
            else
              message = {
                type: 'text',
                text: '機嫌が悪のかな? もう一度呼んでみて'
              }
              client.reply_message(event['replyToken'], message)
            end
          elsif event.message['text'] == '写真を探すよ。撮影日を入力してね'
            send_date_picker(event['replyToken'])
          end
        end
      when Line::Bot::Event::Postback
        handle_postback(event)
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
    begin
      capture_date_str = event['postback']['params']['date']
      capture_date = Date.strptime(capture_date_str, '%Y-%m-%d')
      
      line_id = event['source']['userId']
      user = User.find_by(line_id: line_id)
  
      photos = Photo.joins(:album).where(albums: { user_id: user.id }, capture_date: capture_date.beginning_of_day..capture_date.end_of_day)
  
      if photos.any?
        messages = photos.map do |photo|
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
        puts "Before reply_message"
        client.reply_message(event['replyToken'], messages)
        puts "After reply_message"
      else
        message = {
          type: 'text',
          text: 'ごめんなさい。その日に撮影した写真はないみたい... 
別の日で試してみてね'
        }
        client.reply_message(event['replyToken'], message)
      end
    end
  end  
end
