# fronzen_string_literal: true

class ItemsController < ApplicationController
  def new
    product = ProductsRepository.new.find_by(id: params[:product_id])
    if product
      @item = Item.new(product: product)
    else
      redirect_to products_path, alert: 'Product not found.'
    end
  end

  def create
    @item = Item.new(item_params)
    if CartsRepository.new.add_item(cart: current_cart, item: @item)
      redirect_to cart_path, notice: 'Item added to your cart.'
    else
      flash[:alert] = 'Please check your item(s) again.'
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_id, :quantity)
  end
end
