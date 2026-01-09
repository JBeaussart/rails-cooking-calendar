class MigrateIngredientsFromJsonbToTable < ActiveRecord::Migration[8.1]
  def up
    # Migrate existing JSONB ingredients to the new tables
    execute <<-SQL
      INSERT INTO ingredients (name, user_id, created_at, updated_at)
      SELECT DISTINCT
        INITCAP(TRIM(ingredient::text)),
        recipes.user_id,
        NOW(),
        NOW()
      FROM recipes
      CROSS JOIN LATERAL jsonb_array_elements_text(recipes.ingredients) AS ingredient
      WHERE recipes.ingredients IS NOT NULL
        AND jsonb_array_length(recipes.ingredients) > 0
      ON CONFLICT (user_id, name) DO NOTHING;
    SQL

    # Create recipe_ingredients associations
    execute <<-SQL
      INSERT INTO recipe_ingredients (recipe_id, ingredient_id, created_at, updated_at)
      SELECT
        r.id,
        i.id,
        NOW(),
        NOW()
      FROM recipes r
      CROSS JOIN LATERAL jsonb_array_elements_text(r.ingredients) AS ingredient_name
      JOIN ingredients i ON i.name = INITCAP(TRIM(ingredient_name::text))
                        AND i.user_id = r.user_id
      WHERE r.ingredients IS NOT NULL
        AND jsonb_array_length(r.ingredients) > 0;
    SQL

    # Remove the old JSONB column and its index
    remove_index :recipes, :ingredients
    remove_column :recipes, :ingredients
  end

  def down
    # Add back the JSONB column
    add_column :recipes, :ingredients, :jsonb, default: [], null: false
    add_index :recipes, :ingredients, using: :gin

    # Migrate data back to JSONB
    execute <<-SQL
      UPDATE recipes
      SET ingredients = (
        SELECT COALESCE(jsonb_agg(i.name), '[]'::jsonb)
        FROM recipe_ingredients ri
        JOIN ingredients i ON i.id = ri.ingredient_id
        WHERE ri.recipe_id = recipes.id
      );
    SQL
  end
end
