class UpdateUsersTable < ActiveRecord::Migration[7.0]
  def change
    User.find_each do |user|
    user.update(line_id: user.line_user_id)
  end

    # line_user_idカラムを削除
    remove_column :users, :line_user_id, :string
  end
end
  