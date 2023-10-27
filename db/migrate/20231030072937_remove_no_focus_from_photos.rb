class RemoveNoFocusFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :no_focus, :boolean
  end
end
