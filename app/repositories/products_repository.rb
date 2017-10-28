# frozen_string_literal: true

class ProductsRepository
  delegate :all, :find_by, to: :base_model

  def initialize(base_model: Product, cart_model: Cart)
    @base_model = base_model
    @cart_model = cart_model
  end

  def products_quantities
    cart_model
      .joins(:items)
      .pending
      .group('items.product_id').sum('items.quantity')
  end

  def products_amounts
    cart_model
      .joins(items: [:product])
      .pending
      .group('items.product_id')
      .sum('(items.quantity * products.price)')
  end

  private

  attr_reader :base_model, :cart_model
end
