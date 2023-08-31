class AddIsPublicToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :is_public, :boolean, default: false
  end
end
