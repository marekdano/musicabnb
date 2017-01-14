class HomeController < ApplicationController
  def index
    @locations = Location.includes(:location_images, :member).last(3)
  end
end
