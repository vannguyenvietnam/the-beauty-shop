class Catalogue < ActiveRecord::Base
	has_many :sub_catalogues, class_name: "Catalogue", foreign_key: "parent_id", dependent: :destroy
	belongs_to :parent, class_name: "Catalogue"
	has_many :products

	validates :name, presence: true	

end
