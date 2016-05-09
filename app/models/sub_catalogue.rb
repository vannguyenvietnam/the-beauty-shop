class SubCatalogue < ActiveRecord::Base
  belongs_to :catalogue
  has_many :products
end
