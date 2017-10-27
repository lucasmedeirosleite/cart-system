# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, only: :sessions

  resources :products, only: :index

  resource :cart, only: :show do
    resources :items, expect: [:index, :show]
  end
end
