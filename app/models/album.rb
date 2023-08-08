class Album < ApplicationRecord
  belongs_to :user
  belongs_to :idol
  has_many :photos
end
