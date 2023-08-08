class CreateIdols < ActiveRecord::Migration[7.0]
  def change
    create_table :idols do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :birth_date
      t.boolean :is_selected

      t.timestamps
    end
  end
end
