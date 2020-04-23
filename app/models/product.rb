class Product < ApplicationRecord
  # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
  DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
  # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide

  before_validation :set_default_price
  before_save :capitalize_title

  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }

  private

  def set_default_price
    self.price ||= DEFAULT_PRICE
  end

  def capitalize_title
    self.title.capitalize!
  end

end
