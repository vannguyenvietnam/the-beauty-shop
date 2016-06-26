class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :admin_user, only: [:create, :update, :destroy]  
  before_action :set_sub_catalogues, only: [:new, :create, :edit, :update]
  skip_before_action :verify_authenticity_token, only: [:create]
	respond_to :html, :js
    
  def index    
  	@products = Product.all.paginate(page: params[:page], per_page: 8)    
  end

  def new
    @product = Product.new    
  end

  def create   
    @product = Product.new(name: product_params[:name],
                           description: product_params[:description],
                           price: product_params[:price],
                           quantity: product_params[:quantity],
                           picture: product_params[:picture])    
    sub_cat = Catalogue.find(params[:sub_catalogue_id])    
    sub_cat_pro = @product.cat_products.build(catalogue_id: sub_cat.id)
    cat_pro = @product.cat_products.build(catalogue_id: sub_cat.parent_id)

    if @product.save && sub_cat_pro.save && cat_pro.save
      flash.now[:success] = "Product created." 
      render 'new'        
    else
      flash.now[:danger] = "Product was not created successfully." 
      render 'new'      
    end    
  end

  def edit
    @product = Product.find(params[:id])
    catalogues = @product.catalogues
    if catalogues.first.parent_id.nil?      
      @sub_catalogue = catalogues.second
    else
      @sub_catalogue = catalogues.first
    end
  end

  def show   
  	@product = Product.find(params[:id])  	
  	@order_item = current_order.order_items.new
  end

  def update
    @product = Product.find(params[:id])

    sub_cat = Catalogue.find(params[:sub_catalogue_id])    
    if @product.cat_products.first.catalogue.parent_id.nil?
      @product.cat_products.first.update_attributes(catalogue_id: sub_cat.parent_id)
      @product.cat_products.second.update_attributes(catalogue_id: sub_cat.id)
    else
      @product.cat_products.second.update_attributes(catalogue_id: sub_cat.parent_id)
      @product.cat_products.first.update_attributes(catalogue_id: sub_cat.id)
    end

    catalogues = @product.catalogues
    if catalogues.first.parent_id.nil?      
      @sub_catalogue = catalogues.second
    else
      @sub_catalogue = catalogues.first
    end

    if (@product.update_attributes(product_params))
      # Handle a successful update
      flash.now[:success] = "Product updated" 
      render 'edit'     
    else
      flash.now[:danger] = "Product was not created successfully."
      render 'edit'
    end    
  end

  def destroy
    @product_id = params[:id]
    product = Product.find(@product_id)
    catalogue = product.cat_products.first.catalogue
    product.destroy
    @products = catalogue.products.paginate(page: params[:page], per_page: 8)      
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :picture)
    end

    def set_sub_catalogues
      @sub_catalogues = Catalogue.where("parent_id IS NOT NULL") # sub catalogues
    end

end
