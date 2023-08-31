# config/schedule.rb
set :environment, "development" # 開発環境で動作（本番環境で動かす場合は注意）
set :output, "log/cron_log.log"
set :runner_command, "rails runner"

every 1.minute do # 1.minute
  command "echo 'ｺﾝﾆﾁﾜ'"
end
# 0時〜3時 "未明"
every 1.day, at: '1:30 am' do
  runner "SendPhotoJob.perform_later('midnight')"
end

# 3時〜6時 "明け方"
every 1.day, at: '4:00 am' do
  runner "SendPhotoJob.perform_later('early_morning')"
end

# 6時〜9時 "朝"
every 1.day, at: '8:00 am' do
  runner "SendPhotoJob.perform_later('morning')"
end

# 9時〜12時 "昼前"
every 1.day, at: '10:30 am' do
  runner "SendPhotoJob.perform_later('late_morning')"
end

# 12時〜15時 "昼過ぎ"
every 1.day, at: '12:00 pm' do
  runner "SendPhotoJob.perform_later('early_afternoon')"
end

# 15時〜18時 "夕方"
every 1.day, at: '4:00 pm' do
  runner "SendPhotoJob.perform_later('late_afternoon')"
end

# 18時〜21時 "夜のはじめ頃"
every 1.day, at: '8:00 pm' do
  runner "SendPhotoJob.perform_later('early_evening')"
end

# 21時〜24時 "夜遅く"
every 1.day, at: '10:00 pm' do # '17:50 pm' を '9:50 pm' に修正
  runner "SendPhotoJob.perform_later('late_evening')"
end

env :PATH, ENV['PATH']
