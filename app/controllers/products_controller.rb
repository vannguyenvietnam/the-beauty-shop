class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :admin_user, only: [:create, :update, :destroy]  
  before_action :set_catalogues, only: [:new, :create, :edit, :update]
	respond_to :html, :js
    
  def index    
  	@products = Product.all.paginate(page: params[:page], per_page: 8)
  end

  def new
    @product = Product.new    
  end

  def create   
    @product = Product.new(product_params)    
    if @product.save     
      flash.now[:success] = "Product created"      
      render 'new'
    else
      render 'new'
    end    
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show   
  	@product = Product.find(params[:id])
  	parent_id = @product.catalogue.parent_id
    if parent_id == 0
      @sub_catalogues = @product.catalogue.sub_catalogues
    else
      @sub_catalogues = @product.catalogue.parent.sub_catalogues
    end
  	@order_item = current_order.order_items.new
  end

  def update
    @product = Product.find(params[:id])
    if (@product.update_attributes(product_params))
      # Handle a successful update
      flash.now[:success] = "Product updated"
      render 'edit'
    else
      render 'edit'
    end    
  end

  def destroy
    @product_id = params[:id]
    Product.find(@product_id).destroy      
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :picture, :catalogue_id)
    end

    def set_catalogues
      @catalogues = Catalogue.where("parent_id > :parent_id", parent_id: 0) # sub catalogues
    end

end
