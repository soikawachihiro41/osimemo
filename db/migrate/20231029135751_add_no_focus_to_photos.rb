class AddNoFocusToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :no_focus, :boolean
  end
end
