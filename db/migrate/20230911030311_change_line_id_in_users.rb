class ChangeLineIdInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :line_id, false
  end
end
