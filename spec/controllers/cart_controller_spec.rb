# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { authenticate(user) }

  describe 'GET #show' do
    subject(:get_user_cart) do
      get :show
    end

    it 'renders the cart view' do
      get_user_cart

      expect(response).to render_template(:show)
    end
  end
end
