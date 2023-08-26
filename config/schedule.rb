# config/schedule.rb

# 0時〜3時 "未明"
every 1.day, at: '1:00 am' do
  runner "SendPhotoJob.perform_later('midnight')"
end

# 3時〜6時 "明け方"
every 1.day, at: '4:00 am' do
  runner "SendPhotoJob.perform_later('early_morning')"
end

# 6時〜9時 "朝"
every 1.day, at: '7:00 am' do
  runner "SendPhotoJob.perform_later('morning')"
end

# 9時〜12時 "昼前"
every 1.day, at: '10:00 am' do
  runner "SendPhotoJob.perform_later('late_morning')"
end

# 12時〜15時 "昼過ぎ"
every 1.day, at: '12:16 pm' do
  runner "SendPhotoJob.perform_later('early_afternoon')"
end

# 15時〜18時 "夕方"
every 1.day, at: '4:00 pm' do
  runner "SendPhotoJob.perform_later('late_afternoon')"
end

# 18時〜21時 "夜のはじめ頃"
every 1.day, at: '7:00 pm' do
  runner "SendPhotoJob.perform_later('early_evening')"
end

# 21時〜24時 "夜遅く"
every 1.day, at: '10:00 pm' do
  runner "SendPhotoJob.perform_later('late_evening')"
end
