# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Product, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:price) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }

    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_numericality_of(:price) }
  end
end
