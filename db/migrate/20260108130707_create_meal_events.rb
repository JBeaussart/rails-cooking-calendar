class CreateMealEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_events do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title, null: false
      t.date   :date, null: false
      t.integer :guests_count

      t.timestamps
    end
    add_index :meal_events, :user_id, unique: true
  end
end
