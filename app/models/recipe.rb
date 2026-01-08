class Recipe < ApplicationRecord
  belongs_to :user

  has_many :meal_plans, dependent: :destroy

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :steps, presence: true

  scope :favorites, -> { where(is_favorite: true) }
end
