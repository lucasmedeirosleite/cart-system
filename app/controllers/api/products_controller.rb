# frozen_string_literal: true

module API
  class ProductsController < APIController
    def quantity
      quantities = repository.products_quantities
      if quantities.present?
        render json: quantities, status: :ok
      else
        render json: { message: 'No data.' }, status: :not_found
      end
    end

    def amount
      amounts = repository.products_amounts
      if amounts.present?
        render json: amounts, status: :ok
      else
        render json: { message: 'No data.' }, status: :not_found
      end
    end

    private

    def repository
      @_repository = ProductsRepository.new
    end
  end
end
