# frozen_string_literal: true

class CartsRepository
  delegate :create, :find_by, to: :base_model

  def initialize(base_model: Cart)
    @base_model = base_model
  end

  def last_from(user:)
    user.carts.order(updated_at: :desc).first
  end

  def add_item(cart:, item:)
    item.cart = cart
    item.save
  end

  private

  attr_reader :base_model
end
