class Api::V1::ProductsController < Api::ApplicationController
    before_action :find_product,only:[:show]
    def index
        products=Product.order(created_at: :desc)
        render(json: products, each_serializer: ProductCollectionSerializer)    
    end
    def show
        render json: @product
    end

    private
    def find_product
        @product||=Product.find params[:id]
    end

end
