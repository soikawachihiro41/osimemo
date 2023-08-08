class Photo < ApplicationRecord
  belongs_to :album
  has_many :photo_tags
  has_many :tags, through: :photo_tags
end
