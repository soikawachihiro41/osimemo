# frozen_string_literal: true

# app/services/random_photo_reply_service.rb
class RandomPhotoReplyService
  include Rails.application.routes.url_helpers

  def initialize(event)
    @event = event
  end

  def execute
    user = User.find_by(line_id: @event['source']['userId'])
    idol_data = user.random_idol_with_photo

    if idol_data[:photo]
      image_url = idol_data[:photo].image.url
      show_url = url_for(controller: 'photos', action: 'show', id: idol_data[:photo].id)
      album_name = idol_data[:album].name
      idol_name = idol_data[:idol].name
      FlexMessageBuilder.build(image_url, album_name, idol_name, show_url)
    else
      {
        type: 'text',
        text: '機嫌が悪のかな? もう一度呼んでみて'
      }
    end
  end
end
