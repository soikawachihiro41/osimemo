# frozen_string_literal: true

class PhotoTag < ApplicationRecord
  belongs_to :photo
  belongs_to :tag
end
