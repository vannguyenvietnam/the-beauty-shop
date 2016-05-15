class Product < ActiveRecord::Base
  belongs_to :sub_catalogue
  has_many :order_items

  mount_uploader :picture, PictureUploader

  validates :name, presence: true
end
