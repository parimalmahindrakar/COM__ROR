class MainController < ApplicationController

    before_action :authenticate_user!

    def index
        @customer = Customer.all()
    end


    def create
        @customer = Customer.new
        
        if request.post?
            @customer = Customer.new(customer_params)
            if @customer.save
                redirect_to root_path, notice: "Successfully created account !"
            else
                render :new
            end
        end 

    end


    private
    def customer_params 
        params.require(:customer).permit(:name, :email, :phone, :address)
    end



    def show
        @customer = Customer.find(params[:id])
    end







end