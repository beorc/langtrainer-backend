Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :users do
      delete 'sign_out' => 'api/users/sessions#destroy'
      resource :session, only: :create
      resource :registration, only: :create
      resource :user, only: :update
    end
  end

  root 'trainings#show'
end
