# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :user
  belongs_to :idol
  has_many :photos, dependent: :destroy
  mount_uploader :cover_image, CoverImageUploader
  validates :is_public, inclusion: { in: [true, false] }
  validates :is_open, inclusion: { in: [true, false] }
  validates :name, presence: true
  validates :cover_image, presence: true

  delegate :name, to: :idol, prefix: true

  def viewable_by?(user)
    is_public || (user && user_id == user.id)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name created_at id updated_at] + _ransackers.keys
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[idol user]
  end
end
