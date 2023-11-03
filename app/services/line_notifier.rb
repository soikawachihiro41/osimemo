# frozen_string_literal: true

# app/services/line_notifier.rb
class LineNotifier
  def self.send_birthday_notification(line_id, idol_name)
    message = {
      type: 'text',
      text: "Happy Birthday to #{idol_name}! 🎉 ステキな1日を過ごしてね"
    }

    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET_bot', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end

    client.push_message(line_id, message)
    # 必要に応じて、レスポンスをチェックしてエラーを処理します
  end
end
