class AddUniqueIndexToUsersLineId < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :line_id, unique: true
  end
end
