class LocationImage < ApplicationRecord
  belongs_to :location

  has_attached_file :picture,
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV["AWS_ACESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      bucket: "musicabnb-#{Rails.env}"
    },  
    s3_region: ENV["AWS_REGION"],
    path: "location_images/:attachment/:id/:style/:filename",
    url: ":s3_domain_url",
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '800x800>'
    },
    :default_url => "/images/:style/missing.png"


  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  after_create :set_picture_order

  def set_picture_order
    if location.location_images.count == 1
      update_attribute(:picture_order, 1)
    else
      next_picture_order = location.location_images.count + 1
      update_attribute(:picture_order, next_picture_order)
    end 
  end 
end
