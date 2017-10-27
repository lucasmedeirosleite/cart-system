# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { authenticate(user) }

  describe 'GET #current' do
    subject(:get_user_cart) do
      get :current
    end

    let(:cart) { FactoryBot.create(:cart, user: user) }
    let(:cart_id) { cart.id }

    it 'renders the cart view' do
      get_user_cart

      expect(response).to render_template(:current)
    end
  end
end
