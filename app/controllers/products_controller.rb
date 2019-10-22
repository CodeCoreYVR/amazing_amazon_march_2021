class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    # strong parameters are used primarily as a security practice to help
    # prevent accidentally allowing users to update sensitive model attributes.
    product_params = params.require(:product).permit(:title, :description, :price)
    @product = Product.new product_params
    if @product.save
      # Eventually we will redirect to the show page for the product created
      render plain: "Product Created"
    else
      # render will simply render the new.html.erb view in the views/products
      # directory. The #new action above will not be touched.
      render :new
    end
  end
end
