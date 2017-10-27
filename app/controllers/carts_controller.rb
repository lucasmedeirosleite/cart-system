# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :check_if_belongs_to_user

  def current
  end

  private

  def check_if_belongs_to_user
    if current_cart.user != current_user
      redirect_to root_path, alert: 'This cart does not belong to you.'
    end
  end
end
