class ProductsController < ApplicationController
  def new
  end

  def show
  	@product = Product.find_by(id: params[:id])
  	@sub_catalogues = @product.sub_catalogue.catalogue.sub_catalogues
  	
  end
end
