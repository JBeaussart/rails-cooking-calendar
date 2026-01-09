class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy toggle_favorite]

  def index
    @recipes = current_user.recipes.includes(:ingredients).order(created_at: :desc)
  end

  def favorites
    @recipes = current_user.recipes.favorites.includes(:ingredients).order(created_at: :desc)
    render :index
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params.except(:ingredients_text))
    assign_ingredients_from_text(@recipe, params[:recipe][:ingredients_text])

    if @recipe.save
      redirect_to @recipe, notice: "Recette créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @recipe.assign_attributes(recipe_params.except(:ingredients_text))
    assign_ingredients_from_text(@recipe, params[:recipe][:ingredients_text])

    if @recipe.save
      redirect_to @recipe, notice: "Recette mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recette supprimée avec succès."
  end

  def toggle_favorite
    @recipe.update(is_favorite: !@recipe.is_favorite)
    redirect_back fallback_location: @recipe
  end

  private

  def set_recipe
    @recipe = current_user.recipes.includes(recipe_ingredients: :ingredient).find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :preparation_time, :is_favorite, :ingredients_text, steps: [])
  end

  def assign_ingredients_from_text(recipe, ingredients_text)
    return if ingredients_text.blank?

    lines = ingredients_text.split("\n").map(&:strip).reject(&:blank?)

    # Clear existing ingredients
    recipe.recipe_ingredients.destroy_all

    # Parse and create ingredients
    lines.each do |line|
      parsed = parse_ingredient_line(line)
      ingredient = current_user.ingredients.find_or_create_by!(name: parsed[:name])

      recipe.recipe_ingredients.build(
        ingredient: ingredient,
        quantity: parsed[:quantity],
        unit: parsed[:unit]
      )
    end
  end

  # Parse a line like "200 g farine" or "3 œufs" or "sel"
  def parse_ingredient_line(line)
    # Common units to detect
    units = %w[g kg mg ml L cl dl cuillères? cuillère tasse pincée sachet gousse tranche morceau pièce]
    units_pattern = units.join("|")

    # Try to match: quantity unit name (e.g., "200 g farine")
    if line =~ /^([\d\/.,]+)\s*(#{units_pattern}(?:\s*à\s*(?:soupe|café))?)\s+(.+)$/i
      { quantity: $1.strip, unit: $2.strip, name: $3.strip.capitalize }
    # Try to match: quantity name (e.g., "3 œufs")
    elsif line =~ /^([\d\/.,]+)\s+(.+)$/
      { quantity: $1.strip, unit: nil, name: $2.strip.capitalize }
    # Just name (e.g., "sel")
    else
      { quantity: nil, unit: nil, name: line.strip.capitalize }
    end
  end
end
