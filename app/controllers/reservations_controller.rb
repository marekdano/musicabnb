class ReservationsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :confirmation]

  def index
    @reservations = Reservation.where(member_id: current_member.id)
  end
  
  def new
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location
    @available_dates = @location.available_dates.where(booked: false).pluck(:date).as_json
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location

    respond_to do |format|
      if @reservation.save
        @reservation.dates_booked

        format.html { redirect_to confirmation_reservation_path(@reservation), notice: "Reservation successfully created." }
      else
        format.html { redirect_to location_path(@location), alert: "Some of the dates of your reservation are not available. Please try different dates." }
      end  
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:id])
    @location = @reservation.location
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :location_id, :member_id)
  end

end
