class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :watching]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:destroy, :index]
  respond_to :html, :js

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id]) 
    @products = @user.watching.paginate(page: params[:page], per_page: 8) 
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) 
  	if @user.save
  		# Handle a successful save
      log_in @user
      flash[:success] = "Welcome to The Beauty Shop"
      redirect_to @user # go to user page      
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (@user.update_attributes(user_params))
      # Handle a successful update
      flash.now[:success] = "Profile updated."      
    else
      flash.now[:danger] = "Profile was not updated successfully."           
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash.now[:success] = "User deleted"
    redirect_to users_url
  end

  def watching
    @user = current_user
    @products = @user.watching.paginate(page: params[:page], per_page: 8) 
  end

  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
end
