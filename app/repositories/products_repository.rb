# frozen_string_literal: true

class ProductsRepository
  delegate :all, :find_by, to: :base_model

  def initialize(base_model: Product)
    @base_model = base_model
  end

  def products_quantities
    Product
      .left_outer_joins(items: [:cart])
      .where('carts.status' => Cart.statuses[:pending])
      .group('items.product_id')
      .sum('items.quantity')
  end

  def products_amounts
    Product
      .left_outer_joins(items: [:cart])
      .where('carts.status' => Cart.statuses[:pending])
      .group('items.product_id')
      .sum('(items.quantity * products.price)')
  end

  private

  attr_reader :base_model
end
