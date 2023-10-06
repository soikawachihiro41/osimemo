require 'open-uri'

namespace :images do
  desc "Convert all photos to webp"
  task convert_to_webp: :environment do
    Photo.all.each do |photo|
      # S3のURLを取得
      image_url = photo.image.url

      # S3から画像を一時的にローカルにダウンロード
      image_path = "tmp/#{File.basename(image_url)}"
      File.open(image_path, 'wb') do |file|
        file.write URI.open(image_url).read
      end

      # 画像をwebpに変換
      converted_image_path = "#{image_path}.webp"
      image = MiniMagick::Image.open(image_path)
      image.format("webp")
      image.write(converted_image_path)

      # 変換された画像をS3に再アップロード
      photo.image = File.open(converted_image_path)
      photo.save!

      # 一時的にダウンロードした画像を削除
      File.delete(image_path)
      File.delete(converted_image_path)
    end
  end
end
