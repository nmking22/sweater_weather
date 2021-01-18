class RoadTripFacade
  def self.find_road_trip(params)
    trip_data = LocationService.find_trip_data(params)
    time = trip_data[:route][:realTime]
    coordinates = LocationFacade.find_coordinates(params[:destination])
    weather_at_eta = WeatherFacade.find_weather_at_eta(coordinates, time)
    road_trip = RoadTrip.new(time, params[:origin], params[:destination], weather_at_eta)
  end
end
