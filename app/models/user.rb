class User < ApplicationRecord
  has_many :idols
  has_many :albums
  has_many :birthday_notifications
  has_one :notification_setting, class_name: 'NotificationSetting'
  validates :line_id, presence: true, uniqueness: true
end
