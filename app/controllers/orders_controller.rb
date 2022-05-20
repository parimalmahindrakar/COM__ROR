class OrdersController < ApplicationController

    before_action :authenticate_user!
    

    def index
        # if params[:search]
        #     @order = Order.search(params[:search])
        # else
        #     @order = Order.all
        #     # @customers = Customer.all.order('created_at DESC')
        # end
        # @orders = Order.all
        @orders = Order.paginate(:page => params[:page],per_page: 10)
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
        if updateStockForUpdation() 
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

        # find the damn product !
        product_id = params[:order].require('product_id')
        product = Product.find_by(id: product_id)

        order = Order.find_by(id: params.require(:format))

        quantityBeforeUpdate = order.quantity
        quantityAfterUpdate = params[:order].require('quantity')

        productIdBeforeUpdate = order.product_id
        productIdAfterUpdate = params[:order].require('product_id')

        if productIdAfterUpdate.to_i == productIdBeforeUpdate.to_i

            if quantityBeforeUpdate.to_i >= quantityAfterUpdate.to_i
                stockUpdated = product.stock + (quantityBeforeUpdate.to_i - quantityAfterUpdate.to_i)
                if product.update_attribute(:stock, stockUpdated)
                    return true
                else
                    return false
                end
            elsif product.stock.to_i < (quantityAfterUpdate.to_i - quantityBeforeUpdate.to_i ).abs
                return false
            else 
                stockUpdated = product.stock + (quantityBeforeUpdate.to_i - quantityAfterUpdate.to_i)
                if product.update_attribute(:stock, stockUpdated)
                    return true
                else
                    return false
                end
            end
        
        else

            # samsung total stock is 10 to => got  => 7
            # lenovo total stock is 10 => got  => 7

            productBefore = Product.find_by(id: productIdBeforeUpdate.to_i) # samsung contained 3
            productAfter = Product.find_by(id: productIdAfterUpdate.to_i) # lenovo to update 3 more

            # so samsung will be again 10
            # and lenovo will be 7-3 => 4

            if quantityAfterUpdate.to_i > productAfter.stock
                return false
            else
                if quantityAfterUpdate == quantityBeforeUpdate

                    newStockForAfterProduct = productAfter.stock - quantityAfterUpdate.to_i
                    newStockForBeforeProduct = productBefore.stock +  quantityAfterUpdate.to_i

                    if productBefore.update_attribute(:stock, newStockForBeforeProduct ) &&  productAfter.update_attribute(:stock, newStockForAfterProduct)
                        return true
                    else
                        return false
                    end
                else
                    newStockForAfterProduct = productAfter.stock - quantityAfterUpdate.to_i
                    newStockForBeforeProduct = productBefore.stock +  quantityBeforeUpdate.to_i

                    if productBefore.update_attribute(:stock, newStockForBeforeProduct ) &&  productAfter.update_attribute(:stock, newStockForAfterProduct)
                        return true
                    else
                        return false
                    end

                end

            end

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