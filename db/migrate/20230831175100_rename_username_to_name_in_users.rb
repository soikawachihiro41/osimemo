class RenameUsernameToNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :username, :name
  end
end
