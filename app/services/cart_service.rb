# frozen_string_literal: true

class CartService
  def initialize(repository: CartsRepository)
    @repository = repository
  end

  def current_cart(user: user)
    cart = repository.last_from(user: user)
    return cart if cart && !cart.expired?
    repository.create(user: user)
  end

  private

  attr_reader :repository
end
