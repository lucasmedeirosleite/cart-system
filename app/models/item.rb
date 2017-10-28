class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart_id, :product_id, presence: true

  validates_uniqueness_of :product_id, scope: :cart_id

  def total
    BigDecimal.new(quantity) * product.price
  end
end
