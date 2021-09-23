# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :users, only: %i[index show]
  namespace :api do
    resources :users, only: %i[index show]
  end
  get '/test', to: 'home#test'
end
