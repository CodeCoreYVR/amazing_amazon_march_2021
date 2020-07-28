class AddUserReferencesToFavourites < ActiveRecord::Migration[6.1]
  def change
    add_reference :favourites, :user, null: false, foreign_key: true
  end
end
