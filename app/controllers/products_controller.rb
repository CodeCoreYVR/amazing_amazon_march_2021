class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product!, except: [:create]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
  end

  def create
    # strong parameters are used primarily as a security practice to help
    # prevent accidentally allowing users to update sensitive model attributes.
    product_params = params.require(:product).permit(:title, :description, :price)
    @product = Product.new product_params
    @product.user = @current_user
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
    @review = Review.new
  end

  def edit
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
    @product.destroy
    redirect_to products_path
   end

   private
   def authorize_user!
    unless can? :crud, @product
      flash[:danger] = "Acess Denied"
      redirect_to root_path
    end
   end

   def load_product!
    if params[:id].present?
      @product = Product.find(params[:id])
    else
      @product = Product.new
    end
   end

end
