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
    ActiveRecord::Base.transaction do
      cart.pending!
      item.cart = cart
      item.save
    end
  end

  def find_cart_item(cart:, item_id:)
    cart.items.find_by(id: item_id)
  end

  def remove_item(item:)
    item.destroy
  end

  private

  attr_reader :base_model
end
