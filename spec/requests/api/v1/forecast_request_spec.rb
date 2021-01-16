require 'rails_helper'

describe 'forecast request' do
  it 'returns weather data for the parameter city' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_a(Hash)
      expect(response).to have_key(:data)
      expect(response[:data]).to be_a(Hash)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to eq('null')
      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to eq('forecast')

      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)
      expect(response[:data][:attributes]).to have_key(:current_weather)

      # current weather
      expect(response[:data][:current_weather]).to be_a(Hash)
      expect(response[:data][:current_weather]).to have_key(:datetime)
      expect(response[:data][:current_weather][:datetime]).to be_a(String)
      expect(response[:data][:current_weather]).to have_key(:sunrise)
      expect(response[:data][:current_weather][:sunrise]).to be_a(String)
      expect(response[:data][:current_weather]).to have_key(:sunset)
      expect(response[:data][:current_weather][:sunset]).to be_a(String)
      expect(response[:data][:current_weather]).to have_key(:temperature)
      expect(response[:data][:current_weather][:temperature]).to be_a(Float)
      expect(response[:data][:current_weather]).to have_key(:feels_like)
      expect(response[:data][:current_weather][:feels_like]).to be_a(Float)

      # these three can be ints or floats
      expect(response[:data][:current_weather]).to have_key(:humidity)
      expect(response[:data][:current_weather][:humidity]).to be_a(Float)
      expect(response[:data][:current_weather]).to have_key(:uvi)
      expect(response[:data][:current_weather][:uvi]).to be_a(Float)
      expect(response[:data][:current_weather]).to have_key(:visibility)
      expect(response[:data][:current_weather][:visibility]).to be_a(Float)

      expect(response[:data][:current_weather]).to have_key(:conditions)
      expect(response[:data][:current_weather][:conditions]).to be_a(String)
      expect(response[:data][:current_weather]).to have_key(:icon)
      expect(response[:data][:current_weather][:icon]).to be_a(String)

      # daily weather
      expect(response[:data][:daily_weather]).to be_an(Array)
      expect(response[:data][:daily_weather].length).to eq(5)
      expect(response[:data][:daily_weather][0]).to be_a(Hash)
      expect(response[:data][:daily_weather][0]).to have_key(:date)
      expect(response[:data][:daily_weather][0][:date]).to be_a(String)
      expect(response[:data][:daily_weather][0]).to have_key(:sunrise)
      expect(response[:data][:daily_weather][0][:sunrise]).to be_a(String)
      expect(response[:data][:daily_weather][0]).to have_key(:sunset)
      expect(response[:data][:daily_weather][0][:sunset]).to be_a(String)
      expect(response[:data][:daily_weather][0]).to have_key(:max_temp)
      expect(response[:data][:daily_weather][0][:max_temp]).to be_a(Float)
      expect(response[:data][:daily_weather][0]).to have_key(:min_temp)
      expect(response[:data][:daily_weather][0][:min_temp]).to be_a(Float)
      expect(response[:data][:daily_weather][0]).to have_key(:conditions)
      expect(response[:data][:daily_weather][0][:conditions]).to be_a(String)
      expect(response[:data][:daily_weather][0]).to have_key(:icon)
      expect(response[:data][:daily_weather][0][:icon]).to be_a(String)

      # hourly weather
      expect(response[:data]).to have_key(:hourly_weather)
      expect(response[:data][:hourly_weather]).to be_an(Array)
      expect(response[:data][:hourly_weather].length).to eq(8)
      expect(response[:data][:hourly_weather][0]).to be_a(Hash)
      expect(response[:data][:hourly_weather][0]).to have_key(:time)
      expect(response[:data][:hourly_weather][0][:time]).to be_a(String)
      expect(response[:data][:hourly_weather][0]).to have_key(:temperature)
      expect(response[:data][:hourly_weather][0][:temperature]).to be_a(Float)
      expect(response[:data][:hourly_weather][0]).to have_key(:wind_speed)
      expect(response[:data][:hourly_weather][0][:wind_speed]).to be_a(String)
      expect(response[:data][:hourly_weather][0]).to have_key(:wind_direction)
      expect(response[:data][:hourly_weather][0][:wind_direction]).to be_a(String)
      expect(response[:data][:hourly_weather][0]).to have_key(:conditions)
      expect(response[:data][:hourly_weather][0][:conditions]).to be_a(String)
      expect(response[:data][:hourly_weather][0]).to have_key(:icon)
      expect(response[:data][:hourly_weather][0][:icon]).to be_a(String)
  end
end
