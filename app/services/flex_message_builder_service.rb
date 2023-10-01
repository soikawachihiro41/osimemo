# frozen_string_literal: true

# app/services/flex_message_builder_service.rb

class FlexMessageBuilderService
  def initialize(photo)
    @photo = photo
  end

  def build
    image_url = @photo.image.url
    show_url = Rails.application.routes.url_helpers.url_for(controller: 'photos', action: 'show', id: @photo.id,
                                                            host: 'osi-b2426bac1a6b.herokuapp.com')
    album_name = @photo.album.name
    idol_name = @photo.album.idol.name

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
end
