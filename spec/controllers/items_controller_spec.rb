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
        expect(flash[:alert]).to eq('Please check your item(s) again.')
      end
    end
  end
end
