# app/services/line_notifier.rb
class LineNotifier
  def self.send_birthday_notification(line_id, idol_name)
    message = {
      type: 'text',
      text: "Happy Birthday to #{idol_name}! 🎉 ステキな1日を過ごしてね"
    }

    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    response = client.push_message(line_id, message)
    # 必要に応じて、レスポンスをチェックしてエラーを処理します
  end
end
