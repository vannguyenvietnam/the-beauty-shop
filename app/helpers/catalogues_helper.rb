module CataloguesHelper

	def catalogues
		Catalogue.where("parent_id = :parent_id", parent_id: 0)
	end

end
