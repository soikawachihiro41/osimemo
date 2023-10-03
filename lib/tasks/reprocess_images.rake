# lib/tasks/reprocess_images.rake

namespace :images do
  desc "Reprocess images"
  task reprocess: :environment do
    User.find_each do |user|
      user.avatar.recreate_versions! if user.avatar.present?
      user.save
    end
  end
end
