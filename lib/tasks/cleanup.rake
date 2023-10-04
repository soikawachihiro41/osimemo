namespace :carrierwave do
  desc 'Clean up CarrierWave cache'
  task cleanup_cache: :environment do
    require 'fileutils'

    cache_dir = Rails.root.join('public', 'uploads', 'tmp')
    if Dir.exist?(cache_dir)
      FileUtils.rm_rf(Dir.glob(cache_dir.join('*')))
      puts "CarrierWave cache cleaned!"
    else
      puts "No cache directory found."
    end
  end
end