class Product < ApplicationRecord
  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :favourites, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
  DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
  # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide

  before_validation :set_default_price
  before_save :capitalize_title

  validates :title, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :user
  # has_many accepts a scope as a second argument. This scope will make all associated reviews ordered by their updated_at, see the following example:
=begin
  @product = Product.find(params[:id])
  @product.reviews # will be all the associated reviews for this particular product and due to the scope they're all ordered by updated_at
=end

  has_many :reviews, -> { order('updated_at DESC') }, dependent: :destroy 

  # scope(name, body, &block) is a method that will add a class method for retrieving records
  # https://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-scope
  # in ruby & rails docks &block means the method accepts a lambda.
  scope(:search, -> (query) { where("title ILIKE?", "%#{query}%") })

  # you can create a class method that does the same thing.

  def self.search_but_using_class_method(query)
    where("title ILIKE?", "%#{query}%")
  end

  def increment_hit_count
    new_hit_count = self.hit_count += 1
    update({ hit_count: new_hit_count })
  end

  def self.get_paginated(search, sort_by_col, current_page, per_page_count)
    where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%").order(Hash[sort_by_col, :desc]).limit(per_page_count).offset(current_page * per_page_count) 
  end

  def tag_names
    self.tags.map(&:name).join(", ")
  end

  # Appending = at the end of a method name, allows to implement
  # a "setter". A setter is a method that is assignable.
  # Example:
  # p.tag_names = "stuff,yo"
  # The code in the example above would call the method we wrote
  # below where the value on the right-hand side of the = would
  # become the argument to the method.
  # This is similar to implementing an `attr_writer`.
  def tag_names=(rhs)
    self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
      Tag.find_or_initialize_by(name: tag_name)
    end
  end

  private

  def set_default_price
    self.price ||= DEFAULT_PRICE
  end

  def capitalize_title
    self.title.capitalize!
  end

end
