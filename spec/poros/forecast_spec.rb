require 'rails_helper'

describe 'hour weather' do
  it 'has readable attributes' do
    coordinates = {
      :lat=>29.950621,
      :lng=>-90.074948
    }
    weather = WeatherFacade.find_weather(coordinates)

    forecast = Forecast.new(weather)

    expect(forecast.current_weather).to be_a(CurrentWeather)
    expect(forecast.daily_weather).to be_an(Array)
    forecast.daily_weather.each do |day_weather|
      expect(day_weather).to be_a(DayWeather)
    end
    expect(forecast.hourly_weather).to be_an(Array)
    forecast.hourly_weather.each do |hour_weather|
      expect(hour_weather).to be_a(HourWeather)
    end
  end
end
