class Profile < ApplicationRecord
  belongs_to :member, dependent: :destroy

  validates_presence_of :member_id

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, default_url: "/images/missing-avatar.jpg"

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
