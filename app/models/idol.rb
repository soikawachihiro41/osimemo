# frozen_string_literal: true

class Idol < ApplicationRecord
  belongs_to :user
  has_many :albums, dependent: :destroy
  has_many :birthday_notifications, dependent: :destroy

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :is_selected, inclusion: { in: [true, false] }

  def self.ransackable_attributes(auth_object = nil)
    ["birth_date", "created_at", "id", "is_selected", "name", "updated_at"] # 検索可能な属性をここにリストします
  end
end
