Rails.application.routes.draw do
  resources :tickets, only: %i[index show]

  namespace :api, defaults: { format: :json } do
    resources :tickets, only: :create
  end

  root 'tickets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
