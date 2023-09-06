class AddUploaderIdToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :uploader_id, :integer
    add_foreign_key :photos, :users, column: :uploader_id
  end
end
