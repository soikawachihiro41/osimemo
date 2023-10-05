# frozen_string_literal: true

# lib/tasks/reprocess_photos.rake

namespace :photos do
  desc 'Reprocess all photos'
  task reprocess: :environment do
    Photo.find_each(&:reprocess_image)
  end
end
