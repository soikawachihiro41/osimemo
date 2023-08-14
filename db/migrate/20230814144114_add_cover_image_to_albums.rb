class AddCoverImageToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :cover_image, :string
  end
end
