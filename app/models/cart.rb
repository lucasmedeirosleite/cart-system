# frozen_string_literal: true

class Cart < ApplicationRecord
  enum status: %i[active pending purchased]

  belongs_to :user
  has_many :items

  validates :status, :user, presence: true

  def expired?
    (Time.now - updated_at) > 2.days
  end

  def total
    items.reduce(BigDecimal.new('0')) { |sum, item| sum + item.total }
  end
end
