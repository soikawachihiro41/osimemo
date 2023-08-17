class Idol < ApplicationRecord
  belongs_to :user
  has_many :albums
  has_many :birthday_notifications

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :is_selected, inclusion: { in: [true, false] }
end
