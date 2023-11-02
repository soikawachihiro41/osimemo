# frozen_string_literal: true

# lib/tasks/scheduler.rake
desc 'Send birthday notifications'
task send_birthday_notifications: :environment do
  idols = Idol.today_birthday.includes(:user)
  idols.each do |idol|
    # ここでLINE Messaging APIを使用して通知を送信します。
    LineNotifier.send_birthday_notification(idol.user.line_id, idol.name)
  end
end
