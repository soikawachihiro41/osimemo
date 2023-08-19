class RenameColumnNameToTagNamesInTags < ActiveRecord::Migration[7.0]
  def change
    rename_column :tags, :name, :tag_names
  end
end
