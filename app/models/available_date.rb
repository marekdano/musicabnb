class AvailableDate < ApplicationRecord
  belongs_to :location

  validates_presence_of :date

  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :unreserved, -> { where(booked: false) }
  scope :available_for_reservation, -> (date_range_array) {
    upcoming.unreserved.where(date: date_range_array) if date_range_array.present?
  }
end
