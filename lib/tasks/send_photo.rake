# frozen_string_literal: true

# lib/tasks/send_photo.rake

namespace :send_photo do
  desc 'Send photo based on time period'
  task :perform, [:time_period] => :environment do |_t, args|
    time_period = args[:time_period]
    users = User.find_by(preferred_time: time_period)

    users.find_each do |user|
      SendPhotoService.new(user).perform
    end
  end
end
