# frozen_string_literal: true

class CartService
  def initialize(repository: CartsRepository.new)
    @repository = repository
  end

  def current(user:)
    cart = repository.last_from(user: user)
    cart.expired! if cart&.expired?
    return cart if cart&.available?
    repository.create(user: user)
  end

  private

  attr_reader :repository
end
