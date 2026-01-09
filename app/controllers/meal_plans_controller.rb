class MealPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal_plan, only: %i[edit update destroy]

  def quick_add
    @meal_plan = current_user.meal_plans.find_or_initialize_by(
      date: params[:date],
      meal_type: params[:meal_type]
    )
    @meal_plan.recipe_id = params[:recipe_id]

    if @meal_plan.save
      respond_to do |format|
        format.html { redirect_back fallback_location: recipes_path, notice: "#{@meal_plan.recipe.title} ajouté au #{I18n.l(@meal_plan.date, format: :long)} (#{@meal_plan.meal_type})" }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: recipes_path, alert: "Erreur : #{@meal_plan.errors.full_messages.join(', ')}"
    end
  end

  def index
    @meal_plans = current_user.meal_plans.includes(:recipe).order(date: :asc)
  end

  def edit
    @recipes = current_user.recipes
  end

  def update
    if @meal_plan.update(meal_plan_params)
      redirect_to meal_plans_path, notice: "Planification mise à jour avec succès."
    else
      @recipes = current_user.recipes
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan.destroy
    redirect_to meal_plans_path, notice: "Planification supprimée avec succès."
  end

  private

  def set_meal_plan
    @meal_plan = current_user.meal_plans.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:recipe_id, :date, :meal_type)
  end
end
