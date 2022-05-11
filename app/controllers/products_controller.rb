class ProductsController < ApplicationController

    before_action :authenticate_user!


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


    def delete
        @product = Products.find_by(id: params.require(:format))  
        @product.destroy
        redirect_to(
        products_path,
          notice: 'Product successfully deleted.'
        )
    end


    def edit   
        @product = Products.find_by(id: params.require(:format))    
    end  
    
    def update   
        @product = Products.find_by(id: params.require(:format))    
        if @product.update_attributes(products_params)   
          flash[:notice] = 'Product details updated!'   
          redirect_to products_path   
        else   
          flash[:alert] = 'Failed to update details of product !'   
          render :edit   
        end   
    end






    private
    def products_params 
        params.require(:products).permit(:CompanyName, :Model, :stock, :price, :device)
    end



end