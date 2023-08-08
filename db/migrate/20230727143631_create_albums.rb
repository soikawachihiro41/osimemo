class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.references :user, null: false, foreign_key: true
      t.references :idol, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
