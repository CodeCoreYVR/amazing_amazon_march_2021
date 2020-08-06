class Api::V1::ProductsController < ApplicationController
    def index
        products=Product.order(created_at: :desc)
        render(json: products)    
    end

end
