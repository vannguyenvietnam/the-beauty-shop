class CatProduct < ActiveRecord::Base
	belongs_to :catalogue
	belongs_to :product
end
