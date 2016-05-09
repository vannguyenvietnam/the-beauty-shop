class Product < ActiveRecord::Base
  belongs_to :sub_catalogue
  mount_uploader :picture, PictureUploader
end
