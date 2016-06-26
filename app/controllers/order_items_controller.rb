class OrderItemsController < ApplicationController
  before_action :set_order

  def create  
    @order_item = @order.order_items.find_by(product_id: order_item_params[:product_id])
    if @order_item.nil?	
    	@order_item = @order.order_items.new(order_item_params)
    	@order.save
    	session[:order_id] = @order.id
    else      
      quantity = @order_item.quantity + order_item_params[:quantity].to_i
      @order_item.update_attributes(quantity: quantity)
    end
  end

  def update
  	@order_item = @order.order_items.find_by(id: params[:id])
  	@order_item.update_attributes(order_item_params)
  	@order_items = @order.order_items
  end

  def destroy  	
  	@order_item = @order.order_items.find_by(id: params[:id])
  	@order_item.destroy
  	@order_items = @order.order_items
  end

  private

    def set_order
      @order = current_order
    end

  	def order_item_params
  		params.require(:order_item).permit(:quantity, :product_id)
  	end

end
