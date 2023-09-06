class AddUploaderIdToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :uploader_id, :integer
  end
end
