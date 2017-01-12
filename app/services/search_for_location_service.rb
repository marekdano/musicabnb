class SearchForLocationService
  attr_reader :params

  def initialize(params)
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @address = params[:address]
    @musical_instrument = params[:musical_instrument]
    @guests = params[:guests]
  end

  def matches
    @start_date.empty? || @end_date.empty? ? date_range_array = nil : date_range_array = (@start_date.to_date..(@end_date.to_date - 1.day)).to_a

    Location.nearby(@address)
            .with_available_dates(date_range_array)
            .with_musical_instrument(@musical_instrument)
            .with_guests(@guests)
            .distinct
  end
end