# frozen_string_literal: true

class CartsController < ApplicationController
  def show
  end

  def purchase
    return redirect_to cart_path, alert: 'Your cart is empty.' if current_cart.items.empty?
    CartsRepository.new.purchase(cart: current_cart)
    redirect_to products_path, notice: 'Purchased items successfuly'
  end
end
