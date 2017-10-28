# frozen_string_literal: true

class CartService
  def initialize(repository: CartsRepository.new)
    @repository = repository
  end

  def current(user:)
    cart = repository.last_from(user: user)
    return cart if !cart&.purchased? && !cart.expired?
    repository.create(user: user)
  end

  private

  attr_reader :repository
end
