# lib/tasks/reprocess_photos.rake

namespace :photos do
  desc "Reprocess all photos"
  task reprocess: :environment do
    Photo.find_each do |photo|
      photo.reprocess_image
    end
  end
end
