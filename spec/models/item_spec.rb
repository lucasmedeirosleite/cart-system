# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:quantity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity)
          .only_integer.is_greater_than(0) }

    it { is_expected.to validate_presence_of(:cart_id) }
    it { is_expected.to validate_presence_of(:product_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end
end
