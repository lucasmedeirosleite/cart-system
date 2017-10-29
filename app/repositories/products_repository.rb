# frozen_string_literal: true

class ProductsRepository
  delegate :all, :find_by, to: :base_model

  def initialize(base_model: Product)
    @base_model = base_model
  end

  def products_quantities
    Product
      .joins(items: [:cart])
      .where('carts.status' => Cart.statuses[:pending])
      .group('products.name', 'products.id')
      .select('products.name AS product_name',
              'products.id AS product_id', 'SUM(items.quantity) AS quantity')
      .each_with_object({}) do |result, hash|
        hash[result.product_id] = { product_name: result.product_name, quantity: result.quantity }
      end
  end

  def products_amounts
    Product
      .joins(items: [:cart])
      .where('carts.status' => Cart.statuses[:pending])
      .group('products.name', 'products.id')
      .select('products.name AS product_name',
              'products.id AS product_id', 'SUM(items.quantity * products.price) AS amount')
      .each_with_object({}) do |result, hash|
        hash[result.product_id] = { product_name: result.product_name, amount: result.amount }
      end
  end

  private

  attr_reader :base_model
end
