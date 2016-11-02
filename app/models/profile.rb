class Profile < ApplicationRecord
  belongs_to :member, dependent: :destroy

  validates_presence_of :bio
  validates_presence_of :member_id
end
