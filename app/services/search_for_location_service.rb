class SearchForLocationService
  attr_reader :params

  def initialize(params)
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @address = params[:address]
  end

  def matches
    date_range_array = (@start_date.to_date..(@end_date.to_date - 1.day)).to_a
    Location.nearby(@address).with_available_dates(date_range_array).distinct
  end

end