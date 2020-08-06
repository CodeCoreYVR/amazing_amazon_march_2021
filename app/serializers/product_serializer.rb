class ProductSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :description,
    :price,
    :created_at,
    :updated_at,
    :sale_price,
    :hit_count
  )
  belongs_to :user, key: :seller

  class UserSerializer < ActiveModel::Serializer
    attributes(:id, :first_name, :last_name, :email, :full_name)
  end

  has_many :reviews

  class ReviewSerializer < ActiveModel::Serializer
    attributes(:id, :body, :rating)
  end
end
