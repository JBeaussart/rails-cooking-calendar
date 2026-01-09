class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    # Récupérer les meal_plans d'aujourd'hui et des jours à venir
    upcoming_meal_plans = current_user.meal_plans
      .includes(recipe: { recipe_ingredients: :ingredient })
      .where("date >= ?", Date.today)
      .order(:date)

    # Condenser les ingrédients par nom
    @ingredients_list = condense_ingredients(upcoming_meal_plans)

    # Dates concernées pour l'affichage
    @date_range = {
      start: Date.today,
      end: upcoming_meal_plans.maximum(:date) || Date.today
    }

    @recipes_count = upcoming_meal_plans.count
  end

  private

  def condense_ingredients(meal_plans)
    ingredients_hash = {}

    meal_plans.each do |meal_plan|
      meal_plan.recipe.recipe_ingredients.each do |ri|
        key = ri.ingredient.name.downcase.strip
        
        if ingredients_hash[key]
          # Essayer d'additionner les quantités si même unité
          ingredients_hash[key] = merge_quantities(ingredients_hash[key], ri)
        else
          ingredients_hash[key] = {
            id: ri.ingredient.id,
            name: ri.ingredient.name,
            quantities: [ { quantity: ri.quantity, unit: ri.unit, recipe: meal_plan.recipe.title } ]
          }
        end
      end
    end

    # Trier par nom
    ingredients_hash.values.sort_by { |i| i[:name].downcase }
  end

  def merge_quantities(existing, new_ri)
    # Vérifier si on peut fusionner les quantités (même unité)
    last_qty = existing[:quantities].last
    
    if last_qty[:unit] == new_ri.unit && numeric?(last_qty[:quantity]) && numeric?(new_ri.quantity)
      # Fusionner en additionnant
      existing[:quantities].last[:quantity] = (last_qty[:quantity].to_f + new_ri.quantity.to_f).to_s
      existing[:quantities].last[:recipe] = "#{last_qty[:recipe]}, #{new_ri.recipe.title}"
    else
      # Ajouter séparément
      existing[:quantities] << { quantity: new_ri.quantity, unit: new_ri.unit, recipe: new_ri.recipe.title }
    end

    existing
  end

  def numeric?(str)
    return false if str.nil?
    Float(str) != nil rescue false
  end
end
