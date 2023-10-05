# frozen_string_literal: true

# lib/tasks/reprocess_images.rake
namespace :images do
  desc 'Reprocess profile images'
  task reprocess: :environment do
    User.find_each do |user|
      user.profile_image.recreate_versions! if user.profile_image.present?
      user.save
    end
  end
end
