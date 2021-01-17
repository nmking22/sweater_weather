class ForecastFacade
  def self.find_forecast(location)
    coordinates = LocationFacade.find_coordinates(location)
    weather = WeatherFacade.find_weather(coordinates)
    forecast = Forecast.new(weather)
  end
end
