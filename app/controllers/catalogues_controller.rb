class CataloguesController < ApplicationController
	before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :admin_user, only: [:create, :update, :destroy]
  before_action :create_new_catalogue
	respond_to :html, :js

  def index    
  	@catalogues = Catalogue.where("parent_id = :parent_id", parent_id: 0)  	
  end

  def create
    @catalogue = Catalogue.new(catalogue_params)  
    @catalogue.save    
    @parent_id = @catalogue.parent_id
    if @parent_id > 0
    	@catalogue = Catalogue.find_by(id: parent_id)
    end
    @catalogues = Catalogue.where("parent_id = :parent_id", parent_id: 0)
  end

  def edit
  	@catalogue = Catalogue.find(params[:id]) 
  end

  def show
  	@catalogue = Catalogue.find(params[:id])
  	@sub_catalogues = @catalogue.sub_catalogues  	
  	@products = @sub_catalogues.first.products.paginate(page: params[:page], per_page: 8)   	
  end  	

  def update
    @catalogue = Catalogue.find(params[:id])
    @catalogue.update_attributes(catalogue_params)
    @parent_id = @catalogue.parent_id
    if @parent_id > 0
    	@catalogue = Catalogue.find_by(id: parent_id)
    end
    @catalogues = Catalogue.where("parent_id = :parent_id", parent_id: 0)
  end

  def destroy
  	@cata_id = params[:id]
    catalogue = Catalogue.find(@cata_id)
    @parent_id = catalogue.parent_id
    catalogue.destroy      
  end

  private

    def catalogue_params
      params.require(:catalogue).permit(:name, :parent_id)
    end

    def create_new_catalogue
    	@new_catalogue = Catalogue.new 
    end

end
