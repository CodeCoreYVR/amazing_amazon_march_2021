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
      # render plain: "Product Created"
      # instead of the above line we will use :
      redirect_to @product
      # same as redirect_to product_path(@product)
    else
      # render will simply render the new.html.erb view in the views/products
      # directory. The #new action above will not be touched.
      render :new
    end
  end

  def index
    # @products = Product.all
    @products = Product.order(created_at: :DESC)
  end

  def show
    @product = Product.find params[:id]
  end
  def edit
    @product = Product.find params[:id]
  end

  def update
    product_params = params.require(:product).permit(:title, :description, :price)
    @product = Product.find params[:id]
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
   end
end
