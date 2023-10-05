# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :profile_image, CoverImageUploader
  has_many :idols, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :birthday_notifications, dependent: :destroy
  has_one :notification_setting, class_name: 'NotificationSetting', dependent: :destroy
  # validates :name, presence: true
  validates :line_id, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def self.find_by_preferred_time(time_period)
    joins(:notification_setting).where(notification_settings: { preferred_time: time_period })
  end

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

  User.find_each do |user|
    user.profile_image.recreate_versions! if user.profile_image.present?
    user.save
  end
end
