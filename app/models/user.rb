# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :profile_image, CoverImageUploader
  has_many :idols
  has_many :albums
  has_many :birthday_notifications
  has_one :notification_setting, class_name: 'NotificationSetting'
  # validates :name, presence: true
  validates :line_id, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def random_idol_with_photo
    idol = idols.includes(:albums).where(is_selected: true).sample
    album = idol&.albums&.sample
    photo = album&.photos&.sample
    { idol:, album:, photo: }
  end

  def photos_on_date(date)
    Photo.joins(:album).where(albums: { user_id: id }, capture_date: date.all_day)
  end

  def own?(object)
    object.user_id == id
  end
end
