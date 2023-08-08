class BirthdayNotification < ApplicationRecord
  belongs_to :user
  belongs_to :idol
end
