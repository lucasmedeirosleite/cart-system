class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :cart, :product, presence: true
end
