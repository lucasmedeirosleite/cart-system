# frozen_string_literal: true

module API
  class ProductsController < APIController
    def quantity
      render json: repository.products_quantities, status: :ok
    end

    def amount
      render json: repository.products_amounts, status: :ok
    end

    private

    def repository
      @_repository = ProductsRepository.new
    end
  end
end
