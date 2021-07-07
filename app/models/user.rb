class User < ApplicationRecord
  has_many :idols
  has_many :albums
  has_many :birthday_notification
  has_one :notification_setting
  validates :line_id, presence: true, uniqueness: true
end
