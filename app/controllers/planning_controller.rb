class PlanningController < ApplicationController
  before_action :authenticate_user!

  def index
    @meal_plans = current_user.meal_plans.includes(:recipe).order(date: :asc)
    @meal_events = current_user.meal_events.order(date: :asc)
  end
end
