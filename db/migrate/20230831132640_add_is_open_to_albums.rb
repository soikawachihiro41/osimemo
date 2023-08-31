class AddIsOpenToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :is_open, :boolean, default: false
  end
end
