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
          handle_text(event)
        end
      end
    end

    head :ok
  end

  private

  def handle_text(event)
    text = event.message['text']
    user_id = event['source']['userId']

    if text.match?(/未明|明け方|朝|昼前|昼過ぎ|夕方|夜のはじめ頃|夜遅く/)
      User.find_or_create_by(line_user_id: user_id).update(preferred_time: text)
      reply_text(event, "#{text}に写真を送ります。")
    else
      reply_text(event, text)
    end
  end

  def reply_text(event, text)
    message = {
      type: 'text',
      text: text
    }
    client.reply_message(event['replyToken'], message)
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
