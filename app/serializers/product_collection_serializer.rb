class ProductCollectionSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :description,
    :price,
    :created_at,
    :updated_at,
    :seller_full_name
  )

  def seller_full_name
    object.user&.full_name
  end
end
