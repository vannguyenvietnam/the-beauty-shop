class Product < ActiveRecord::Base
  belongs_to :sub_catalogue
  has_many :order_items
  has_many :watcheds, class_name: "Watching", dependent: :destroy
  has_many :watchers, through: :watcheds, source: :user

  mount_uploader :picture, PictureUploader

  validates :name, presence: true
end
