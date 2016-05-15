class ProductsController < ApplicationController
  def new
  end

  def show
  	@product = Product.find_by(id: params[:id])
  	@sub_catalogues = @product.sub_catalogue.catalogue.sub_catalogues
  	@order_item = current_order.order_items.new
  end
end
