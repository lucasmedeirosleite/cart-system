class Cart < ApplicationRecord
  enum status: [:active, :pending, :purchased]

  belongs_to :user
  has_many :items

  validates :status, :user, presence: true

  def expired?
    (Time.now - updated_at) > 2.days
  end
end
