class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient_id, uniqueness: { scope: :recipe_id }

  # Common units for ingredients
  UNITS = %w[g kg ml L cl pièce(s) cuillère(s)\ à\ soupe cuillère(s)\ à\ café tasse(s) pincée(s)].freeze

  # Display the ingredient with quantity and unit
  def display_name
    parts = []
    parts << quantity if quantity.present?
    parts << unit if unit.present?
    parts << ingredient.name
    parts.join(" ")
  end
end
