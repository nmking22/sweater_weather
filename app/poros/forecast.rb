class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(weather)
    @id = 'null'
    @current_weather = weather[:current_weather]
    @daily_weather = weather[:daily_weather]
    @hourly_weather = weather[:hourly_weather]
  end
end
