# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, only: :sessions

  resources :products, only: :index

  resource :cart, only: :show do
    resources :items, except: [:index, :show]
  end
end
