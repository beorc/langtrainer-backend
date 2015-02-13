Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    match '*path', to: 'application#handle_options_request', via: :options, constraints: { method: 'OPTIONS' }

    resources :feedback, only: :create

    namespace :users do
      resource :session, only: :create
      resource :registration, only: :create

      delete 'sign_out' => 'sessions#destroy'
      put 'update' => 'users#update'

      resource :activation, only: :update
      resource :password_reset, only: [:create, :update] do
        member do
          post 'reset' => 'password_resets#reset'
        end
      end
    end
  end

  namespace :users do
    get 'activate' => 'activations#activate'
    resources :password_resets, only: :edit
  end

  resource :about, only: :show

  root 'trainings#show'
end
