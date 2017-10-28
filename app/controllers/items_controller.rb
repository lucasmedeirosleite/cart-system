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
    if repository.add_item(cart: current_cart, item: @item)
      redirect_to cart_path, notice: 'Item added to your cart.'
    else
      render :new
    end
  end

  def destroy
    item = repository.find_cart_item(cart: current_cart, item_id: params[:id])
    repository.remove_item(item: item)
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def edit
    @item = repository.find_cart_item(cart: current_cart, item_id: params[:id])
    return redirect_to cart_path, alert: 'Cart item not found.' unless @item
  end

  def update
    @item = repository.find_cart_item(cart: current_cart, item_id: params[:id])
    if @item.update(item_params)
      redirect_to cart_path, notice: 'Item updated.'
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_id, :quantity)
  end

  def repository
    @_repository ||= CartsRepository.new
  end
end
