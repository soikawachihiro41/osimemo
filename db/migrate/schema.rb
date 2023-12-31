# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_911_030_311) do
  create_table 'albums', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'idol_id', null: false
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'cover_image'
    t.boolean 'is_public', default: false
    t.boolean 'is_open', default: false
    t.index ['idol_id'], name: 'index_albums_on_idol_id'
    t.index ['user_id'], name: 'index_albums_on_user_id'
  end

  create_table 'birthday_notifications', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'idol_id', null: false
    t.date 'notify_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['idol_id'], name: 'index_birthday_notifications_on_idol_id'
    t.index ['user_id'], name: 'index_birthday_notifications_on_user_id'
  end

  create_table 'idols', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'name'
    t.date 'birth_date'
    t.boolean 'is_selected'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_idols_on_user_id'
  end

  create_table 'notification_settings', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'preferred_time'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_notification_settings_on_user_id'
  end

  create_table 'photo_tags', force: :cascade do |t|
    t.integer 'photo_id', null: false
    t.integer 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['photo_id'], name: 'index_photo_tags_on_photo_id'
    t.index ['tag_id'], name: 'index_photo_tags_on_tag_id'
  end

  create_table 'photos', force: :cascade do |t|
    t.integer 'album_id', null: false
    t.string 'image'
    t.datetime 'capture_date'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'uploader_id'
    t.index ['album_id'], name: 'index_photos_on_album_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'tag_names'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'line_id', null: false
    t.integer 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'profile_image'
  end

  add_foreign_key 'albums', 'idols'
  add_foreign_key 'albums', 'users'
  add_foreign_key 'birthday_notifications', 'idols'
  add_foreign_key 'birthday_notifications', 'users'
  add_foreign_key 'idols', 'users'
  add_foreign_key 'notification_settings', 'users'
  add_foreign_key 'photo_tags', 'photos'
  add_foreign_key 'photo_tags', 'tags'
  add_foreign_key 'photos', 'albums'
  add_foreign_key 'photos', 'users', column: 'uploader_id'
end
