class Idol < ApplicationRecord
  belongs_to :user
  has_many :albums
  accepts_nested_attributes_for :albums
  has_many :birthday_notifications
end
