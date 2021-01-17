require 'rails_helper'

describe 'forecast request' do
  it 'returns weather data for the parameter city' do
      get '/api/v1/forecast?location=denver,co'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq('null')
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('forecast')

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:current_weather)

      # current weather
      expect(json[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(json[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(json[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(json[:data][:attributes][:current_weather]).to have_key(:sunrise)
      expect(json[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(json[:data][:attributes][:current_weather]).to have_key(:sunset)
      expect(json[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(json[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)

      # these three can be ints or floats
      expect(json[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(json[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(json[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Integer)
      expect(json[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(json[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)

      expect(json[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(json[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(json[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)

      # daily weather
      expect(json[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(json[:data][:attributes][:daily_weather].length).to eq(5)
      expect(json[:data][:attributes][:daily_weather][0]).to be_a(Hash)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:date)
      expect(json[:data][:attributes][:daily_weather][0][:date]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(json[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
      expect(json[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
      expect(json[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
      expect(json[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:conditions)
      expect(json[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather][0]).to have_key(:icon)
      expect(json[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)

      # hourly weather
      expect(json[:data][:attributes]).to have_key(:hourly_weather)
      expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(json[:data][:attributes][:hourly_weather].length).to eq(8)
      expect(json[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(json[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(json[:data][:attributes][:hourly_weather][0][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:wind_speed)
      expect(json[:data][:attributes][:hourly_weather][0][:wind_speed]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:wind_direction)
      expect(json[:data][:attributes][:hourly_weather][0][:wind_direction]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(json[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
      expect(json[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
  end
end
