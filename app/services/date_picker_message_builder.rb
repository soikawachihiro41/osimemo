# frozen_string_literal: true

# app/services/date_picker_message_builder.rb
class DatePickerMessageBuilder
  def self.build(_reply_token)
    {
      type: 'template',
      altText: '日付を選択してください',
      template: {
        type: 'buttons',
        text: '日付を選択',
        actions: [
          {
            type: 'datetimepicker',
            label: '日付を選択',
            data: 'action=choose_date',
            mode: 'date'
          }
        ]
      }
    }
  end
end
