class SubCataloguesController < ApplicationController
	respond_to :html, :js
  
  def new
  end
 	
 	def show
 		@sub_catalogue = SubCatalogue.find_by(id: params[:id])
  	@sub_catalogues = @sub_catalogue.catalogue.sub_catalogues  	
  	@products = @sub_catalogue.products.paginate(page: params[:page], per_page: 8)
 	end

end
