# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, only: :sessions

  resources :products, only: :index

  resources :users, only: [] do
    resources :carts, only: :show do
      resources :items, only: [:new, :create]
    end
  end
end
