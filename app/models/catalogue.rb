class Catalogue < ActiveRecord::Base
	has_many :sub_catalogues

	#validates :name, presense: true

	def products
		sub_catalogue_ids = "SELECT id FROM sub_catalogues WHERE catalogue_id = :cata_id"
		Product.where("sub_catalogue_id IN (#{sub_catalogue_ids})", cata_id: id)
	end

end
