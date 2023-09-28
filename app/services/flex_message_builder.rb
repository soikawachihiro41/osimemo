# frozen_string_literal: true

# app/services/flex_message_builder.rb
class FlexMessageBuilder
  def self.build(image_url, album_name, idol_name, show_url)
    {
      type: 'flex',
      altText: 'This is a Flex Message',
      contents: {
        type: 'bubble',
        body: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: 'image',
              url: image_url,
              size: 'full',
              aspectMode: 'cover',
              aspectRatio: '1:1',
              gravity: 'center',
              action: {
                type: 'uri',
                label: 'View Details',
                uri: show_url
              }
            },
            {
              type: 'box',
              layout: 'horizontal',
              contents: [
                {
                  type: 'box',
                  layout: 'vertical',
                  contents: [
                    {
                      type: 'text',
                      size: 'xl',
                      color: '#ffffff',
                      text: album_name,
                      align: 'start'
                    },
                    {
                      type: 'text',
                      text: idol_name,
                      color: '#ffffff',
                      size: 'md',
                      flex: 0,
                      align: 'start'
                    }
                  ],
                  spacing: 'xs'
                }
              ],
              position: 'absolute',
              offsetBottom: '0px',
              offsetStart: '0px',
              offsetEnd: '0px',
              paddingAll: '20px'
            }
          ],
          paddingAll: '0px'
        }
      }
    }
  end
end
