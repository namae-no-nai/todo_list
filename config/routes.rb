Rails.application.routes.draw do
  devise_for :users
  resources :tasks, only: %i[index new create edit update]
  root to: "tasks#index"
end
