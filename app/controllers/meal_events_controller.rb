class MealEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal_event, only: %i[show edit update destroy]

  def index
    @meal_events = current_user.meal_events.order(date: :asc)
  end

  def show
  end

  def new
    @meal_event = current_user.meal_events.build
  end

  def create
    @meal_event = current_user.meal_events.build(meal_event_params)

    if @meal_event.save
      redirect_to @meal_event, notice: "Événement créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @meal_event.update(meal_event_params)
      redirect_to @meal_event, notice: "Événement mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_event.destroy
    redirect_to meal_events_path, notice: "Événement supprimé avec succès."
  end

  private

  def set_meal_event
    @meal_event = current_user.meal_events.find(params[:id])
  end

  def meal_event_params
    params.require(:meal_event).permit(:title, :date, :guests_count)
  end
end
