# fronzen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { authenticate(user) }

  describe 'GET #new' do
    subject(:get_new_item) do
      get :new, params: { product_id: product_id }
    end

    context 'when product does not exist' do
      let(:product_id) { 123 }

      it 'redirects to products list' do
        get_new_item

        expect(response).to redirect_to(products_path)
      end

      it 'sets the flash with a not found message' do
        get_new_item

        expect(flash[:alert]).to eq('Product not found.')
      end
    end

    context 'when product exists' do
      let(:product) { FactoryBot.create(:product) }
      let(:product_id) { product.id }

      it 'renders the new template' do
        get_new_item

        expect(response).to render_template(:new)
      end

      it 'assigns item' do
        get_new_item

        expect(assigns[:item]).to be_an(Item)
        expect(assigns[:item].product).to eq(product)
      end
    end
  end

  describe 'POST #create' do
    subject(:create_item) do
      post :create, params: { item: item_params }
    end

    let(:product) { FactoryBot.create(:product) }

    let(:item_params) do
      { product_id: product.id, quantity: quantity }
    end

    context 'when validation succeeds' do
      let(:quantity) { 2 }

      it 'redirects to cart path' do
        create_item

        expect(response).to redirect_to(cart_path)
        expect(flash[:notice]).to eq('Item added to your cart.')
        expect(Item.count).to eq(1)
      end
    end

    context 'when validation fails' do
      let(:quantity) { nil }

      it 'redirects to cart path' do
        create_item

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:remove_item) do
      delete :destroy, params: { id: item.id }
    end

    let(:item) { FactoryBot.create(:item, cart: cart, product: product, quantity: 2) }
    let(:cart) { FactoryBot.create(:cart, user: user) }
    let(:product) { FactoryBot.create(:product) }

    it 'removes the product from cart' do
      remove_item

      expect(response).to redirect_to(cart_path)
      expect(flash[:notice]).to eq('Item removed from cart.')
      expect(Item.count).to be_zero
    end
  end

  describe 'GET #edit' do
    subject(:edit_item) do
      get :edit, params: { id: item_id }
    end

    context 'when item does not exist' do
      let(:item_id) { 123 }

      it 'renders the cart page' do
        edit_item

        expect(response).to redirect_to(cart_path)
        expect(flash[:alert]).to eq('Cart item not found.')
      end
    end

    context 'when item exists' do
      let(:item_id) { item.id }
      let(:item) { FactoryBot.create(:item, product: product, cart: cart, quantity: 2) }
      let(:cart) { FactoryBot.create(:cart, user: user) }
      let(:product) { FactoryBot.create(:product) }

      it 'render the item edit page' do
        edit_item

        expect(response).to render_template(:edit)
        expect(assigns[:item]).to eq(item)
      end
    end
  end

  describe 'PATCH #update' do
    subject(:update_item) do
      patch :update, params: { id: item.id, item: item_params }
    end

    let(:item) { FactoryBot.create(:item, cart: cart, product: product, quantity: 2) }
    let(:cart) { FactoryBot.create(:cart, user: user) }
    let(:product) { FactoryBot.create(:product) }

    let(:item_params) do
      { product_id: product.id, quantity: 3 }
    end

    it 'updates the item' do
      update_item

      expect(response).to redirect_to(cart_path)
      expect(flash[:notice]).to eq('Item updated.')
      item.reload
      expect(item.quantity).to eq(3)
    end
  end
end
