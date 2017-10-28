# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :carts

  validates :name, presence: true
end
