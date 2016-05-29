class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CataloguesHelper
  include SessionsHelper
  helper_method :current_order
  
  def current_order
  	if !session[:order_id].nil?
  		Order.find_by(id: session[:order_id])
  	else
  		Order.new
  	end
  end  

  private

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
    
    # Confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
