class WeatherFacade
  def self.find_weather(coordinates)
    weather_data = WeatherService.find_weather_data(coordinates)
    weather_hash = Hash.new
    weather_hash[:current_weather] = CurrentWeather.new(weather_data[:current])
    weather_hash[:daily_weather] = []
    weather_data[:daily].first(5).each do |day_weather|
      weather_hash[:daily_weather] << DayWeather.new(day_weather)
    end
    weather_hash[:hourly_weather] = []
    weather_data[:hourly].first(8).each do |hour_weather|
      weather_hash[:hourly_weather] << HourWeather.new(hour_weather)
    end
    weather_hash
  end
end
