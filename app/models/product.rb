class Product < ApplicationRecord
  # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
  DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
  # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide

  before_validation :set_default_price
  before_save :capitalize_title

  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }

  # scope(name, body, &block) is a method that will add a class method for retrieving records
  # https://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-scope
  # in ruby & rails docks &block means the method accepts a lambda.
  scope(:search, -> (query) { where("title ILIKE?", "%#{query}%") })

  # you can create a class method that does the same thing.

  def self.search_but_using_class_method(query)
    where("title ILIKE?", "%#{query}%")
  end

  private

  def set_default_price
    self.price ||= DEFAULT_PRICE
  end

  def capitalize_title
    self.title.capitalize!
  end

end
