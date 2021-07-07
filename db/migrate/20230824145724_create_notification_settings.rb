class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.references :user, foreign_key: true
      t.string :preferred_time

      t.timestamps
    end
  end
end
