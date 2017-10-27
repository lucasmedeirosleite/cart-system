# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:items) }
  end

  describe '#expired?' do
    subject(:cart) { FactoryBot.create(:cart, created_at: today, updated_at: today) }

    let(:today) { DateTime.new(2_017, 10, 26) }

    before { Timecop.freeze(today) }
    after { Timecop.return }

    context 'when 2 days not passed' do
      let(:one_day_after) { today + 1.day }

      before { Timecop.travel(one_day_after) }

      it { is_expected.not_to be_expired }
    end

    context 'when 2 days passed' do
      let(:two_days_after) { today + 2.days }

      before { Timecop.travel(two_days_after) }

      it { is_expected.to be_expired }
    end
  end
end
