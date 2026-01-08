class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true

      t.string  :title, null: false
      t.jsonb   :ingredients, null: false, default: []
      t.jsonb   :steps, null: false, default: []

      t.integer :preparation_time

      t.boolean :is_favorite, default: false

      t.timestamps
    end

    add_index :recipes, :ingredients, using: :gin
    add_index :recipes, :steps, using: :gin
  end
end
