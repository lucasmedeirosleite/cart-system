# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:quantity) { |i| i + 1 }
  end
end
