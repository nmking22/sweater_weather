require 'rails_helper'

describe 'weather service' do
  describe 'class methods' do
    it 'find_weather_data' do
      coordinates = {
        :lat=>29.950621,
        :lng=>-90.074948
      }
      data = WeatherService.find_weather_data(coordinates)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:current)
      expect(data[:current]).to be_a(Hash)
      expect(data[:current]).to have_key(:dt)
      expect(data[:current][:dt]).to be_an(Integer)
      expect(data[:current]).to have_key(:sunrise)
      expect(data[:current][:sunrise]).to be_an(Integer)
      expect(data[:current]).to have_key(:sunset)
      expect(data[:current][:sunset]).to be_an(Integer)
      expect(data[:current]).to have_key(:temp)
      expect(data[:current][:temp]).to be_a(Float)
      expect(data[:current]).to have_key(:feels_like)
      expect(data[:current][:feels_like]).to be_a(Float)
      expect(data[:current]).to have_key(:humidity)
      expect(data[:current][:humidity]).to be_an(Integer)
      expect(data[:current]).to have_key(:uvi)
      expect(data[:current][:uvi]).to be_an(Integer)
      expect(data[:current]).to have_key(:visibility)
      expect(data[:current][:visibility]).to be_an(Integer)
      expect(data[:current]).to have_key(:weather)
      expect(data[:current][:weather]).to be_an(Array)
      expect(data[:current][:weather][0]).to have_key(:description)
      expect(data[:current][:weather][0][:description]).to be_a(String)
      expect(data[:current][:weather][0]).to have_key(:icon)
      expect(data[:current][:weather][0][:icon]).to be_a(String)
    end
  end
end
