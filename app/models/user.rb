class User < ApplicationRecord
  has_many :idols
  has_many :albums
  has_many :birthday_notification
  validates :line_user_id, presence: true, uniqueness: true
end
