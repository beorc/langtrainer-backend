Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    match '*path', to: 'application#handle_options_request', via: :options, constraints: { method: 'OPTIONS' }

    resources :feedback, only: :create

    namespace :users do
      delete 'sign_out' => 'sessions#destroy'
      resource :session, only: :create
      resource :registration, only: :create
      resource :user, only: :update
    end
  end

  resource :about, only: :show

  root 'trainings#show'
end
