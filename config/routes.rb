# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions
  resources :accounts
  resources :issues
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/issues/show", to: "issues#show"
  get '/', to: 'issues#index', as: :markets
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
end
