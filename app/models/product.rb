class Product < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
end
