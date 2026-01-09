class AddUnitToRecipeIngredients < ActiveRecord::Migration[8.1]
  def change
    add_column :recipe_ingredients, :unit, :string
  end
end
