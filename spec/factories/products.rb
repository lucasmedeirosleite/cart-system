# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |i| "Product #{i}" }
    sequence(:price) { |i| BigDecimal.new('100.5') + BigDecimal.new(i.to_s) }
  end
end
