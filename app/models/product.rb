class Product < ActiveRecord::Base
  has_many :cat_products
  has_many :catalogues, through: :cat_products
  has_many :order_items
  has_many :watcheds, class_name: "Watching", dependent: :destroy
  has_many :watchers, through: :watcheds, source: :user

  mount_uploader :picture, PictureUploader
  #default_scope { where(active: true) }

  validates :name, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :picture_size

  private

  	# Validates the size of an uploaded picture.
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture, "should be less than 5MB")
  		end
  	end

end
