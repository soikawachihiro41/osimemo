class CreateBirthdayNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :birthday_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :idol, null: false, foreign_key: true
      t.date :notify_date

      t.timestamps
    end
  end
end
