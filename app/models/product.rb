class Product < ApplicationRecord
  belongs_to :order

  enum status: [:draft, :published, :archived]

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_one_attached :cover_image
  has_many_attached :images

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
