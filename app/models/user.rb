class User < ApplicationRecord
  mount_uploader :profile_image, CoverImageUploader
  has_many :idols
  has_many :albums
  has_many :birthday_notifications
  has_one :notification_setting, class_name: 'NotificationSetting'
  #validates :name, presence: true
  validates :line_user_id, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def own?(object)
    object.user_id == id
  end
end
