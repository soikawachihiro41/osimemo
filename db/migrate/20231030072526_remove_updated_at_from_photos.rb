class RemoveUpdatedAtFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :updated_at, :datetime
  end
end
