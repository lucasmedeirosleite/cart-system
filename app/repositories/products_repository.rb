# frozen_string_literal: true

class ProductsRepository
  delegate :all, :find_by, to: :base_model

  def initialize(base_model: Product)
    @base_model = base_model
  end

  private

  attr_reader :base_model
end
