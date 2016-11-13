class Profile < ApplicationRecord
  belongs_to :member, dependent: :destroy

  validates_presence_of :member_id

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, 
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV["AWS_ACESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      bucket: "musicabnb-#{Rails.env}"
    },  
    s3_region: ENV["AWS_REGION"],
    path: "profile/:attachment/:id/:style/:filename",
    url: ":s3_domain_url",
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }, 
    # the default image is in the public/images/..
    default_url: "/images/missing-avatar.jpg"
    # or default_url: "missing_:style.png"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
