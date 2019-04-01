class ItemImage < ApplicationRecord
  belongs_to :item,optional: true
  mount_uploader :image, ImageUploader
  validates :image,presence: true,length: { minimum: 1, maximum: 10 }
end
