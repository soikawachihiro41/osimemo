class AddNotNullConstraintToPhotos < ActiveRecord::Migration[7.0]
  def change
    change_column_null :photos, :album_id, false
  end
end
