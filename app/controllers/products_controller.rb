class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product!, except: [:create]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
  
    if params[:tag]

      @tag = Tag.find_or_initialize_by(name: params[:tag])
      @products = @tag.products.order(created_at: :DESC)
    else
      @products = Product.order(created_at: :DESC)
    end
  end

  def new
  end

  def create
    # strong parameters are used primarily as a security practice to help
    # prevent accidentally allowing users to update sensitive model attributes.
 
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

  # def index
  #   # @products = Product.all
  #   @products = Product.order(created_at: :DESC)
  # end

  def show
    @review = Review.new
    @favourite = @product.favourites.find_by_user_id current_user if user_signed_in?
  end

  def edit
  end

  def update
    # product_params = params.require(:product).permit(:title, :description, :price )
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
  

  def product_params
    # docs about params.require() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-require
    # docs about .permit() https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit
    params.require(:product).permit(:title, :description, :price, :sale_price, :tag_names)
  end

   def load_product!
    # params_tag= params[:tag]
    if params[:id].present?
      @product = Product.find(params[:id])
    else
      @product = Product.new
    end
   end

end
