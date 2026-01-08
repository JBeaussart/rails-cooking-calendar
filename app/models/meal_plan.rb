class MealPlan < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :date, presence: true
  validates :meal_type, presence: true
  validates :meal_type, uniqueness: { scope: %i[user_id date] }

  MEAL_TYPES = %w[breakfast lunch dinner snack].freeze

  validates :meal_type, inclusion: { in: MEAL_TYPES }
end
