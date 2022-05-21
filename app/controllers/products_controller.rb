class ProductsController < ApplicationController

    before_action :authenticate_user!


    def index


        if params[:orderby] && params[:ordering]
            @product = Product.order("#{params[:orderby]} #{params[:ordering]}").paginate(:page => params[:page],per_page: 10)
            render :index
        end

        if params[:search]
            @product = Product.search(params[:search]).paginate(:page => params[:page],per_page: 5)
        else
            # @product = Product.all
            @product = Product.paginate(:page => params[:page],per_page: 10)
        end
            
    end

    def new
        @product  = Product.new
    end

    def create
        @product = Product.new(products_params)
        if @product.save
            redirect_to products_path, notice: "Successfully added product !"
        else
            render 'new'
        end
    end


    def delete
        @product = Product.find_by(id: params.require(:format))  
        @product.destroy
        redirect_to(
        products_path,
          notice: 'Product successfully deleted.'
        )
    end


    def edit   
        @product = Product.find_by(id: params.require(:format))    
    end  
    
    def update   
        @product = Product.find_by(id: params.require(:format))    
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
        params.require(:product).permit(:companyname, :model, :stock, :price, :device  )
    end



end