class Recipe < ApplicationRecord
  belongs_to :user

  has_many :meal_plans, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, presence: true
  validates :steps, presence: true

  scope :favorites, -> { where(is_favorite: true) }

  # Helper to get ingredient names as array (for search compatibility)
  # Uses map instead of pluck to leverage eager loading
  def ingredient_names
    ingredients.map(&:name)
  end

  # Helper to get ingredients formatted for text area (quantity unit name)
  def ingredients_text
    recipe_ingredients.includes(:ingredient).map(&:display_name).join("\n")
  end
end
