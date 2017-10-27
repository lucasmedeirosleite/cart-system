# frozen_string_literal: true

class ProductsRepository
  def initialize(base_model: Product)
    @base_model = base_model
  end

  def all
    base_model.order(:name)
  end

  private

  attr_reader :base_model
end
