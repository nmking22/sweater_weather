require 'rails_helper'

describe 'weather facade' do
  describe 'class methods' do
    before :each do
      @coordinates = {
        :lat=>29.950621,
        :lng=>-90.074948
      }
    end
    it 'find_weather' do
      data = WeatherFacade.find_weather(@coordinates)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:current_weather)
      expect(data[:current_weather]).to be_a(CurrentWeather)

      expect(data).to have_key(:daily_weather)
      expect(data[:daily_weather]).to be_an(Array)
      expect(data[:daily_weather].length).to eq(5)
      data[:daily_weather].each do |day_weather|
        expect(day_weather).to be_a(DayWeather)
      end

      expect(data).to have_key(:hourly_weather)
      expect(data[:hourly_weather].length).to eq(8)
      data[:hourly_weather].each do |hour_weather|
        expect(hour_weather).to be_an(HourWeather)
      end
    end

    it 'find_weather_at_eta' do
      weather = WeatherFacade.find_weather_at_eta(@coordinates, 260000)

      expect(weather).to be_a(WeatherAtEta)
      expect(weather.conditions).to be_a(String)
      expect(weather.temperature).to be_a(Float)
    end
  end
end
