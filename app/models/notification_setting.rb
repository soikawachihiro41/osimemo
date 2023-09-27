# frozen_string_literal: true

class NotificationSetting < ApplicationRecord
  belongs_to :user

  def self.create_or_update_by_user(user, setting_params)
    setting = find_by(user_id: user.id) || new(user_id: user.id)
    setting.assign_attributes(setting_params)
    setting.save
  end
end
