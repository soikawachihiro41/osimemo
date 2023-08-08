class Idol < ApplicationRecord
  belongs_to :user
  has_many :albums
  has_many :birthday_notifications
end
