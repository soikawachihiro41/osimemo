class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.references :album, null: false, foreign_key: true
      t.string :image
      t.datetime :capture_date
      t.text :body

      t.timestamps
    end
  end
end
