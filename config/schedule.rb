# config/schedule.rb
require File.expand_path(File.dirname(__FILE__) + "/environment")
set :environment, :production
set :output, "log/cron_log.log"
set :runner_command, "rails runner"

ENV.each { |k, v| env(k, v) }
every 1.minutes do
  runner "SendPhotoJob.perform_now('未明')"
end
# 0時〜3時 "未明"
every 1.day, at: '0:00 am' do
  runner "SendPhotoJob.perform_now('未明')"
end

# 3時〜6時 "明け方"
every 1.day, at: '4:00 am' do
  runner "SendPhotoJob.perform_now('明け方')"
end

# 6時〜9時 "朝"
every 1.day, at: '8:00 am' do
  runner "SendPhotoJob.perform_now('朝')"
end

# 9時〜12時 "昼前"
every 1.day, at: '10:30 am' do
  runner "SendPhotoJob.perform_now('昼前')"
end

# 12時〜15時 "昼過ぎ"
every 1.day, at: '12:45 am' do
  runner "SendPhotoJob.perform_now('昼過ぎ')"
end

# 15時〜18時 "夕方"
every 1.day, at: '4:00 pm' do
  runner "SendPhotoJob.perform_now('夕方')"
end

# 18時〜21時 "夜のはじめ頃"
every 1.day, at: '8:00 pm' do
  runner "SendPhotoJob.perform_now('夜のはじめ頃')"
end

# 21時〜24時 "夜遅く"
every 1.day, at: '11:00 pm' do 
  runner "SendPhotoJob.perform_now('夜遅く')"
end
