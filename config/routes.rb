Rails.application.routes.draw do
  devise_for :users

  root "meal_plans#index"

  resources :recipes do
    member do
      patch :toggle_favorite
    end

    collection do
      get :favorites
    end
  end

  resources :meal_events
  
  get "shopping_list", to: "shopping_list#index", as: :shopping_list

  resources :meal_plans, except: [ :show, :new, :create ] do
    collection do
      post :quick_add
    end
  end
end
