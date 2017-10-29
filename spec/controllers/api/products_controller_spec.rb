# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::ProductsController, type: :controller do
  let(:cart_status) { Cart.statuses[:pending] }

  let(:user) { FactoryBot.create(:user) }

  let(:product_1) { FactoryBot.create(:product, price: BigDecimal.new('2')) }
  let(:product_2) { FactoryBot.create(:product, price: BigDecimal.new('3')) }

  let(:cart_1) { FactoryBot.create(:cart, user: user, status: cart_status) }
  let!(:item_1) { FactoryBot.create(:item, cart: cart_1, product: product_1, quantity: 2) }
  let!(:item_2) { FactoryBot.create(:item, cart: cart_1, product: product_2, quantity: 3) }

  let!(:cart_2) { FactoryBot.create(:cart, user: user, status: cart_status) }
  let!(:item_3) { FactoryBot.create(:item, cart: cart_2, product: product_1, quantity: 3) }
  let!(:item_4) { FactoryBot.create(:item, cart: cart_2, product: product_2, quantity: 4) }

  describe 'GET #quantity' do
    subject(:get_quantity) { get :quantity }

    it 'returns a json with product quantity' do
      get_quantity

      expect(response).to have_node(product_1.id)
      expect(response).to have_node(:product_name).with(product_1.name)
      expect(response).to have_node(:quantity).with(5)

      expect(response).to have_node(product_2.id)
      expect(response).to have_node(:product_name).with(product_2.name)
      expect(response).to have_node(:quantity).with(7)
    end
  end

  describe 'GET #amount' do
    subject(:get_amount) { get :amount }

    it 'returns a json with product amount' do
      get_amount

      expect(response).to have_node(product_1.id)
      expect(response).to have_node(:product_name).with(product_1.name)
      expect(response).to have_node(:amount).with('10.0')

      expect(response).to have_node(product_2.id)
      expect(response).to have_node(:product_name).with(product_2.name)
      expect(response).to have_node(:amount).with('21.0')
    end
  end
end
