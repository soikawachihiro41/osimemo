# frozen_string_literal: true

class BirthdayNotification < ApplicationRecord
  belongs_to :user
  belongs_to :idol
end
