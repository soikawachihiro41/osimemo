# frozen_string_literal: true

class Idol < ApplicationRecord
  belongs_to :user
  has_many :albums, dependent: :destroy
  has_many :birthday_notifications, dependent: :destroy

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :is_selected, inclusion: { in: [true, false] }
end
