# config/schedule.rb
require File.expand_path(File.dirname(__FILE__) + "/environment")
set :environment, "development" # 開発環境で動作（本番環境で動かす場合は注意）
set :output, "log/cron_log.log"
set :runner_command, "rails runner"

#every 1.minutes do
  #runner "SendPhotoJob.perform_now('late_evening')"
#end
# 0時〜3時 "未明"
every 1.day, at: '1:30 am' do
  runner "SendPhotoJob.perform_now('midnight')"
end

# 3時〜6時 "明け方"
every 1.day, at: '4:00 am' do
  runner "SendPhotoJob.perform_now('early_morning')"
end

# 6時〜9時 "朝"
every 1.day, at: '8:00 am' do
  runner "SendPhotoJob.perform_now('morning')"
end

# 9時〜12時 "昼前"
every 1.day, at: '10:30 am' do
  runner "SendPhotoJob.perform_now('late_morning')"
end

# 12時〜15時 "昼過ぎ"
every 1.day, at: '12:45 am' do
  runner "SendPhotoJob.perform_now('early_afternoon')"
end

# 15時〜18時 "夕方"
every 1.day, at: '4:00 pm' do
  runner "SendPhotoJob.perform_now('late_afternoon')"
end

# 18時〜21時 "夜のはじめ頃"
every 1.day, at: '8:10 pm' do
  runner "SendPhotoJob.perform_now('early_evening')"
end

# 21時〜24時 "夜遅く"
every 1.day, at: '11:00 pm' do 
  runner "SendPhotoJob.perform_now('late_evening')"
end
