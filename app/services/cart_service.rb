# frozen_string_literal: true

class CartService
  def initialize(repository: CartsRepository.new)
    @repository = repository
  end

  def current(user:)
    cart = repository.last_from(user: user)
    if cart
      cart.expired! if cart.expired?
      return cart if cart.active? || cart.pending?
    end
    repository.create(user: user)
  end

  private

  attr_reader :repository
end
