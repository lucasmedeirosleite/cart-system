# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = ProductsRepository.new.all
  end
end
