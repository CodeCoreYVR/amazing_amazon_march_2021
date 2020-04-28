class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find params[:product_id]
    @review = Review.new params.require(:review).permit(:rating, :body)
    @review.product = @product
    @review.user = @current_user
    
    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end
  
  def destroy
    @review = Review.find params[:id]
    @review.delete
    redirect_to product_path(@review.product)
  end
end
