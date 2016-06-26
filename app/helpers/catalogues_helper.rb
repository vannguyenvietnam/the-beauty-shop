module CataloguesHelper

	def catalogues
		Catalogue.where("parent_id IS NULL")
	end

	def get_sub_catalogues(cat_id)
		Catalogue.find(cat_id).sub_catalogues
	end

end
