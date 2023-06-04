class Route
  attr_accessor :starting_station, :end_station, :current_stations

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @current_stations= []
  end

  def add_current_station(station)
    @current_stations << station
  end

  def delete_current_station
    @current_stations.delete(station)
  end

  def show_route
    [@starting_station, *@current_stations, @end_station]
  end
end