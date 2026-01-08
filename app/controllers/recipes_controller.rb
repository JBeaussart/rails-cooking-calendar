class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy toggle_favorite]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def favorites
    @recipes = current_user.recipes.favorites.order(created_at: :desc)
    render :index
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recette créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
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
    @recipe = current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :preparation_time, :is_favorite, ingredients: [], steps: [])
  end
end
