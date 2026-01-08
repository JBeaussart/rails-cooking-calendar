Rails.application.routes.draw do
  root "planning#index"

  devise_for :users

  resources :recipes do
    member do
      patch :toggle_favorite
    end

    collection do
      get :favorites
    end
  end

  resources :meal_events
  resources :meal_plans do
    collection do
      post :quick_add
    end
  end
end
