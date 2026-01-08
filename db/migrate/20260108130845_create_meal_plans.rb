class CreateMealPlans < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.date :date, null: false
      t.string :meal_type, null: false # lunch / dinner / etc.

      t.timestamps
    end

    add_index :meal_plans, [ :user_id, :date ]
    add_index :meal_plans, [ :user_id, :date, :meal_type ], unique: true
  end
end
