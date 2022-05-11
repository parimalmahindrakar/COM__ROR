class ProductsController < ApplicationController


    def index
        @product = Products.all
    end

    def new
        @product  = Products.new
    end

    def create
        @product = Products.new(products_params)
        if @product.save
            redirect_to products_path, notice: "Successfully added product !"
        else
            render 'new'
        end
    end


    def show
        @product = Products.find_by(id: params.require(:format))  
    end



    private
    def products_params 
        params.require(:products).permit(:CompanyName, :Model, :stock, :price, :device)
    end



end