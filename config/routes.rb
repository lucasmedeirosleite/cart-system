# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, only: :sessions

  resources :products, only: :index

  resources :carts, only: [] do
    get :current, on: :collection
    resources :items, expect: :show
  end
end
