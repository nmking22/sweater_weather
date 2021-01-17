require 'rails_helper'

describe 'forecast facade' do
  describe 'class methods' do
    it 'find_forecast' do
      location = 'new orleans,la'

      forecast = ForecastFacade.find_forecast(location)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(CurrentWeather)

      expect(forecast.daily_weather).to be_an(Array)
      forecast.daily_weather.each do |day_weather|
        expect(day_weather).to be_a(DayWeather)
      end

      expect(forecast.hourly_weather).to be_an(Array)
      forecast.hourly_weather.each do |hour_weather|
        expect(hour_weather).to be_an(HourWeather)
      end
    end
  end
end
