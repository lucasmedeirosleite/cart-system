# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true

  has_many :items
end
