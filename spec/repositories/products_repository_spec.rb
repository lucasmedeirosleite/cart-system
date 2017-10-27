# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsRepository, type: :repository do
  subject(:repository) { ProductsRepository.new }

  describe '#all' do
    let(:all) { repository.all }

    context 'when there is products' do
      let!(:products) { FactoryBot.create_list(:product, 3) }

      it 'returns the stored products' do
        expect(all).to eq(products)
      end
    end

    context 'when there is no products' do
      it 'returns no products' do
        expect(all).to be_empty
      end
    end
  end
end
