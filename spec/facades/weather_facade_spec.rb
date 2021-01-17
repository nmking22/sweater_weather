require 'rails_helper'

describe 'weather facade' do
  describe 'class methods' do
    it 'find_weather' do
      coordinates = {
        :lat=>29.950621,
        :lng=>-90.074948
      }

      data = WeatherFacade.find_weather(coordinates)

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
  end
end
