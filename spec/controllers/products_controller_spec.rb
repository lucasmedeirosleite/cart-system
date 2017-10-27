# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { authenticate(user) }

  describe 'GET #index' do
    subject(:get_products) { get :index }

    it 'renders index template' do
      get_products

      expect(response).to render_template(:index)
    end

    context 'when there is no products' do
      it 'assigns an empty array' do
        get_products

        expect(assigns[:products]).to be_empty
      end
    end

    context 'when there are products' do
      let!(:products) { FactoryBot.create_list(:product, 3) }

      it 'assigns the existent products' do
        get_products

        expect(assigns[:products]).to eq(products)
      end
    end
  end
end
