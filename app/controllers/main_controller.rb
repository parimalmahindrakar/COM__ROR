class MainController < ApplicationController

    before_action :authenticate_user!

    def index
        @customer = Customer.all()
    end


    def new
        @customer = Customer.new
    end


    def create
        @customer = Customer.new
        
        if request.post?
            @customer = Customer.new(customer_params)
            if @customer.save
                redirect_to root_path, notice: "Successfully created account !"
            else
                render 'new'
            end
        end 

    end



    def show
        # puts(params.require(:id))
        @customer = Customer.find_by(id: params.require(:id))
    end


    private
    def customer_params 
        params.require(:customer).permit(:name, :email, :phone, :address)
    end



    







end