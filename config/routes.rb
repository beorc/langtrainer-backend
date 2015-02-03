Rails.application.routes.draw do
  delete 'sign_out' => 'api/users/sessions#destroy', as: 'sign_out'

  namespace :api, defaults: { format: :json } do
    namespace :users do
      resource :session, only: :create
      resource :registration, only: :create
    end
  end

  root 'trainings#show'
end
