# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name)  { |i| "User #{i}" }
    sequence(:email) { |i| "email#{i}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
