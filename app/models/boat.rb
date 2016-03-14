class Boat < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :goods, dependent: :destroy
end
