# lib/tasks/send_photo.rake
namespace :send_photo do
  desc "Send photo based on time period"
  task :perform, [:time_period] => :environment do |t, args|
    time_period = args[:time_period]
    users = User.joins(:notification_setting)
                .where(notification_settings: { preferred_time: time_period })
    
    if users.empty?
      Rails.logger.info("No users found for time_period #{time_period}")
      next
    end
  
    users.find_each do |user|
      idols = user.idols.includes(:albums).where(is_selected: true)
  
      if idols.empty?
        Rails.logger.info("No selected idols for user #{user.id}")
        next
      end
  
      idol = idols.sample
      album = idol.albums.sample
  
      if album.nil?
        Rails.logger.info("No albums found for idol #{idol.id}")
        next
      end
  
      photo = album.photos.sample
  
      if photo.nil?
        Rails.logger.info("No photos found for album #{album.id}")
        next
      end
  
      image_url = photo.image.url
      show_url = Rails.application.routes.url_helpers.url_for(controller: 'photos', action: 'show', id: photo.id, host: 'osi-b2426bac1a6b.herokuapp.com')      
      album_name = photo.album.name
      idol_name = photo.album.idol.name
      message = build_flex_message(image_url, album_name, idol_name, show_url)
  
      client = Line::Bot::Client.new do |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      end
  
      response = client.push_message(user.line_id, message)
  
      # APIからのレスポンスをログに出力
      Rails.logger.info("API Response: #{response}")
    end
  end

  def build_flex_message(image_url, album_name, idol_name, show_url)
    {
      type: 'flex',
      altText: 'This is a Flex Message',
      contents: {
        type: 'bubble',
        header: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'text',
              text: 'Daily Memory',
              weight: 'bold',
              color: '#aaaaaa',
              size: 'sm'
            }
          ]
        },
        hero: {
          type: 'image',
          url: image_url,
          size: 'full',
          aspectRatio: '20:13',
          aspectMode: 'cover',
          action: {
            type: 'uri',
            uri: show_url
          }
        },
        body: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: 'text',
              text: 'Your lovely memory for today',
              weight: 'bold',
              size: 'xl',
              color: '#fff1f2'
            },
            {
              type: 'text',
              text: "#{idol_name} - #{album_name}",
              wrap: true,
              color: '#666666',
              size: 'md'
            }
          ]
        },
        footer: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'button',
              style: 'primary',
              color: '#fff1f2',
              height: 'sm',
              action: {
                type: 'uri',
                label: 'View More',
                uri: show_url
              }
            }
          ]
        }
      }
    }
  end
  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET_bot"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
