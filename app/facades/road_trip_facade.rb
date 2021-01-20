class RoadTripFacade
  def self.find_road_trip(params)
    trip_data = LocationService.find_trip_data(params)
    time = trip_data[:route][:realTime]
    if time
      self.possible_trip(params, time)
    else
      RoadTrip.new('impossible', params[:origin], params[:destination], nil)
    end
  end

  def self.possible_trip(params, time)
    coordinates = LocationFacade.find_coordinates(params[:destination])
    weather_at_eta = WeatherFacade.find_weather_at_eta(coordinates, time)
    RoadTrip.new(time, params[:origin], params[:destination], weather_at_eta)
  end
end
