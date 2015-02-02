Rails.application.routes.draw do
  delete 'sign_out' => 'user_sessions#destroy', as: 'sign_out'
  get 'sign_in' => 'user_sessions#new', as: 'sign_in'

  resources :user_sessions, only: :create
  resources :users, only: :create

  root 'trainings#show'
end
