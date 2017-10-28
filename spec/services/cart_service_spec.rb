# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartService, type: :service do
  subject(:service) { CartService.new(repository: repository) }
  let(:repository) { CartsRepository.new }

  let(:user) { FactoryBot.create(:user) }

  describe '#current' do
    subject(:current_cart) { service.current_cart(user: user) }

    let(:cart_status) { Cart.statuses[:active] }

    let(:today) { Time.now }

    before { Timecop.freeze(today) }

    after { Timecop.return }

    context 'when there is no cart' do
      it 'returns a new cart' do
        expect {
          current_cart
        }.to change {
          Cart.count
        }.by(1)
      end
    end

    context 'when purchased' do
      let(:cart_status) { Cart.statuses[:purchased] }

      before do
        FactoryBot.create(:cart,
                          user: user,
                          status: cart_status,
                          created_at: today,
                          updated_at: today)
      end

      it 'returns a new active cart' do
        expect {
          current_cart
        }.to change {
          Cart.count
        }.by(1)
      end
    end

    context 'when expired' do
      let(:two_from_today) { today + 2.days }

      before do
        Timecop.travel(two_from_today)
        FactoryBot.create(:cart, user: user, created_at: today, updated_at: today)
      end

      it 'returns a new active cart' do
        expect {
          current_cart
        }.to change {
          Cart.count
        }.by(1)
      end
    end

    context 'when not expired' do
      let(:tomorrow) { today + 1.day }
      let!(:cart) do
        FactoryBot.create(:cart, user: user, created_at: today, updated_at: today)
      end

      before { Timecop.travel(tomorrow) }

      it 'returns the already created cart' do
        expect {
          current_cart
        }.not_to change { Cart.count }
        expect(current_cart).to eq(cart)
      end
    end
  end
end
