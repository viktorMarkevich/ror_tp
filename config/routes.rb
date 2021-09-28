Rails.application.routes.draw do
  resources :tickets, only: %i[index show]

  namespace :api do
    resources :tickets, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
