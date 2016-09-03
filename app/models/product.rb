class Product < ActiveRecord::Base
  has_many :cat_products
  has_many :catalogues, through: :cat_products
  has_many :order_items
  has_many :watcheds, class_name: "Watching", dependent: :destroy
  has_many :watchers, through: :watcheds, source: :user

  mount_uploader :picture, PictureUploader
  #default_scope { where(active: true) }

  validates :name, presence: true  
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :picture_size
  
  # Elasticsearch
  # include Searchable
  #
    # Delete the previous products index in Elasticsearch
    # Product.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

    # Create the new index with the new mapping
    # Product.__elasticsearch__.client.indices.create \
    #  index: Article.index_name,
    #  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

    # Index all article records from the DB to Elasticsearch
    # Product.import # # for auto sync model with elastic search 

  private

  	# Validates the size of an uploaded picture.
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture, "should be less than 5MB")
  		end
  	end

end
