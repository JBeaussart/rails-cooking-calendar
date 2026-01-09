class Ingredient < ApplicationRecord
  belongs_to :user

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }

  # Normalize name before saving
  before_save :normalize_name

  private

  def normalize_name
    self.name = name.strip.downcase.capitalize if name.present?
  end
end
