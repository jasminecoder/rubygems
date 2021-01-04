Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  root 'home#index'
  get 'home/activity', to: 'home#activity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
