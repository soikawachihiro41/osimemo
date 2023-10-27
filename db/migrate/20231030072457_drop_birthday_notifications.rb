class DropBirthdayNotifications < ActiveRecord::Migration[7.0]
  def change
    drop_table :birthday_notifications
  end
end
