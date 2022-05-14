class OrdersController < ApplicationController

    before_action :authenticate_user!
    

    def index
        @orders = Order.all
    end


    def new
        @order = Order.new

    end

    def create
        @order = Order.new(orders_params)
        if updateStockForCreation()
            if @order.save
                redirect_to orders_path, notice: "Successfully added order !"
            else
                render 'new'
            end
        else
            flash[:alert] = 'Quantity is greater than available stock !'   
            render :new
        end 

    end

    def edit   
        @order = Order.find_by(id: params.require(:format))    
    end  
    
    def update   
        @order = Order.find_by(id: params.require(:format))    
        if updateStockForUpdation() == 0
            if @order.update_attributes(orders_params)   
                flash[:notice] = 'Order details updated!'   
                redirect_to orders_path   
            else   
                flash[:alert] = 'Failed to update details of order !'   
                render :edit   
            end 
        else   
            flash[:alert] = 'Quantity is greater than available stock !'   
            render :edit   
        
        end
    end

    def delete
        if updateStockForDeletion()
            @order = Order.find_by(id: params.require(:format))  
            @order.destroy
            redirect_to(
            orders_path,
            notice: 'Order successfully deleted.'
            )
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


    def updateStockForCreation
        product_id = params[:order].require('product_id')
        quantity = params[:order].require('quantity')
        product = Product.find_by(id: product_id)  
        if quantity.to_i > product.stock.to_i
            return false
        else
            stockUpdated = product.stock.to_i - quantity.to_i
            if product.update_attribute(:stock, stockUpdated)
                return true
            else
                return false
            end
        end
    end


    def updateStockForUpdation
        product_id = params[:order].require('product_id')
        product = Product.find_by(id: product_id)
        order = Order.find_by(id: params.require(:format))
        quantity_ = params[:order].require('quantity')
        quantityBeforeUpdate = order.quantity
        quantityAfterUpdate = params[:order].require('quantity')

        puts("quantityBeforeUpdate : ", quantityBeforeUpdate)
        puts("quantityAfterUpdate : ", quantityAfterUpdate )


        if quantityBeforeUpdate.to_i >= quantityAfterUpdate.to_i

            stockUpdated = product.stock + (quantityBeforeUpdate.to_i - quantityAfterUpdate.to_i)
            if product.update_attribute(:stock, stockUpdated)
                return 0
            else
                puts(product.stock.to_i, "is less than", (quantityBeforeUpdate.to_i -  quantityAfterUpdate.to_i).abs)
                return false
            end

        end

        if product.stock.to_i < (quantityBeforeUpdate.to_i -  quantityAfterUpdate.to_i).abs
            puts("fasdfajdsfklfjadskfl;jfklsdfjdkl;fasjl;s")
            return false
        end
        
    end

    def updateStockForDeletion
        order = Order.find_by(id: params.require(:format))
        product = Product.find_by(id: order.product_id) 
        quantityBeforeUpdate = order.quantity
        stockUpdated = product.stock + quantityBeforeUpdate
         
        if product.update_attribute(:stock, stockUpdated)
            return true
        else
            return false
        end
        
    end






end