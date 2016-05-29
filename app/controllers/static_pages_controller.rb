class StaticPagesController < ApplicationController

  def home
  	@sub_catalogues = catalogues.first.sub_catalogues
  	@products = @sub_catalogues.first.products.paginate(page: params[:page], per_page: 8)
  end

end
