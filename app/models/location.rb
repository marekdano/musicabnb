class Location < ApplicationRecord
  belongs_to :member

  has_many :location_images, dependent: :destroy
  accepts_nested_attributes_for :location_images, allow_destroy: true

  has_many :reservations, dependent: :destroy
  has_many :available_dates, dependent: :destroy

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

  scope :nearby, ->(address) { near(address, 50) if address.present? }
  scope :with_available_dates, ->(date_range_array) {
    joins(:available_dates)
    .merge(AvailableDate.available_for_reservation(date_range_array)) if date_range_array.present?
  }

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

  def create_available_dates(start_date, end_date)
    dates = start_date.to_datetime.upto(end_date.to_datetime)
    dates.each do |date|
      AvailableDate.find_or_create_by(date: date, location_id: self.id, booked: false)
    end
  end

  def future_available_dates
   future_dates = AvailableDate.where("date >= ?", Date.today)
   future_dates.where(booked: false)
   #or
   #future_dates.where(reservation_id: nil)
  end
end
