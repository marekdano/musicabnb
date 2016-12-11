class Location < ApplicationRecord
  belongs_to :member, dependent: :destroy

  has_many :location_images
  accepts_nested_attributes_for :location_images, allow_destroy: true

  validates_presence_of :title, 
                        :description, 
                        :address_1, 
                        :city,
                        :state,
                        :musical_instrument,
                        :night_rate,
                        :guests,  
                        :member_id

  geocoded_by :full_street_address

  after_validation :geocode, if: ->(obj){ obj.address_1.present? and obj.address_changed? }
  after_validation :lat_changed?


  def full_street_address
    [address_1, city, state].compact.join(", ")
  end

  def address_changed?
    address_1_changed? || city_changed? || state_changed?
  end

  # This is used to make sure that our address is actually parsed 
  # properly and we get a valuable lat/long
  def lat_changed?
    if (self.address_changed?)
      if !(self.latitude_changed?)
        self.errors.add(:address, "is not valid")
        return false
      end
    end
    return true
  end

end
