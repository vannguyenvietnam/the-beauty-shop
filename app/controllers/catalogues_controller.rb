class CataloguesController < ApplicationController
	
  def new
  end

  def show
  	@catalogue = Catalogue.find_by(id: params[:id])
  	@sub_catalogues = @catalogue.sub_catalogues  	
  	@products = @catalogue.products.paginate(page: params[:page], per_page: 8)  
  end  	

end
