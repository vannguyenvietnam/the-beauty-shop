class WatchingsController < ApplicationController
  before_action :logged_in_user
	respond_to :html, :js

  def new
  end

  def create
  	@user = current_user
  	@product = Product.find_by(id: params[:product_id])
  	@watching = @user.watch(@product)  		
  end

  def destroy
  	@user = current_user
  	@watching = @user.watchings.find_by(id: params[:id])
  	@product = @watching.product
  	@watching.destroy  	
    @products = @user.watching.paginate(page: params[:page], per_page: 8) 
  end
  
end
