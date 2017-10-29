# frozen_string_literal: true

class CartService
  def initialize(repository: CartsRepository.new)
    @repository = repository
  end

  def current(user:)
    cart = repository.last_from(user: user)
    return cart if cart && !cart.purchased? && !cart.expired?
    cart.expired! if cart
    repository.create(user: user)
  end

  private

  attr_reader :repository
end
