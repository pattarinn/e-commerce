class Order < ApplicationRecord
  has_many :products

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end