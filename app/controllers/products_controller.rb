class ProductsController < ApplicationController
	respond_to :html, :js
  
  def new
    @product = Product.new
  end

  def index
    @catalogues = Catalogue.all
  	@products = Product.all.paginate(page: params[:page], per_page: 8)
  end

  def edit
    @products = Product.all.paginate(page: params[:page], per_page: 8)
  end

  def show   
  	@product = Product.find_by(id: params[:id])
  	@sub_catalogues = @product.sub_catalogue.catalogue.sub_catalogues
  	@order_item = current_order.order_items.new
  end
end
