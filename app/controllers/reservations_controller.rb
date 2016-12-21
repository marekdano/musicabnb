class ReservationsController < ApplicationController
  
  def index
    @reservations = Reservation.where(member_id: current_member.id)
  end
  
  def new
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location
  end

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to confirmation_reservation_path(@reservation), notice: "Reservation successfully created." }
      else
        format.html { render :new, alert: "Some of the dates of your reservation are not available. Please try different dates." }
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
