# frozen_string_literal: true

# LINEbotMessage
class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  include Rails.application.routes.url_helpers

  MAX_PHOTOS = 4

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    client.parse_events_from(body).each { |event| handle_event(event) }
    head :ok
  end

  private

  def handle_event(event)
    case event
    when Line::Bot::Event::Message
      handle_message_event(event)
    when Line::Bot::Event::Postback
      handle_postback(event)
    end
  end

  def handle_message_event(event)
    user_input = event.message['text']

    case user_input
    when '何が出るかな...'
      send_random_photo_reply(event)
    when '写真を探すよ。撮影日を入力してね'
      send_date_picker(event['replyToken'])
    end
  end

  # app/controllers/line_bot_controller.rb
  def send_random_photo_reply(event)
    message = RandomPhotoReplyService.new(event).execute
    client.reply_message(event['replyToken'], message)
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET_bot', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end

  def send_date_picker(reply_token)
    message = DatePickerMessageBuilder.build(reply_token)
    client.reply_message(reply_token, message)
  end

  def handle_postback(event)
    PostbackHandler.new(event).handle
  end
end
