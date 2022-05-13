class OrdersController < ApplicationController


    def index
        @orders = Order.all
    end


    def new
        @order = Order.new

    end

    def create

        @order = Order.new(orders_params)
        if @order.save
            redirect_to orders_path, notice: "Successfully added order !"
        else
            render 'new'
        end

    end


    private
    def orders_params 
        ap = params.require(:order).permit(:quantity, :status, :customer_id, :product_id)
        ap[:amount] = calculateAmt
        ap
    end

    def calculateAmt
        product_id = params[:order].require('product_id')
        quantity = params[:order].require('quantity')
        originalPrice = Product.find_by(id: product_id).price
        quantity.to_i * originalPrice
    end

        






end