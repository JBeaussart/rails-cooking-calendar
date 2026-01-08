class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :meal_events, dependent: :destroy
  has_many :meal_plans, dependent: :destroy

  enum :role, { user: 0, premium: 1, admin: 2 }, default: :user
end
