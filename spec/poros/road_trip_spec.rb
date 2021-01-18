require 'rails_helper'

describe 'road trip' do
  before :each do
    json_data = File.read('spec/fixtures/weather_data.json')
    data = JSON.parse(json_data, symbolize_names: true)
    time = 260000
    @weather = WeatherAtEta.new(data, time)

    @road_trip = RoadTrip.new(time, 'denver,co', 'buffalo,ny', @weather)
  end

  it 'has readable attributes' do
    expect(@road_trip.start_city).to eq('Denver, CO')
    expect(@road_trip.end_city).to eq('Buffalo, NY')
    expect(@road_trip.travel_time).to eq('3 day(s), 0 hour(s), 13 minute(s)')
    expect(@road_trip.weather_at_eta).to eq(@weather)
  end

  describe 'instance methods' do
    it 'format_city' do
      city = 'denver,co'
      city_2 = 'dEnVeR,cO'
      # city = 'new orleans,la'
      expect(@road_trip.format_city(city)).to eq('Denver, CO')
      expect(@road_trip.format_city(city_2)).to eq('Denver, CO')
    end

    it 'convert_time' do
      time = 260000
      time_2 = 10
      time_3 = 5000
      time_4 = 3000
      time_5 = 10000

      expect(@road_trip.convert_time(time)).to eq('3 day(s), 0 hour(s), 13 minute(s)')
      expect(@road_trip.convert_time(time_2)).to eq('10 second(s)')
      expect(@road_trip.convert_time(time_3)).to eq('1 hour(s), 23 minute(s)')
      expect(@road_trip.convert_time(time_4)).to eq('50 minute(s)')
      expect(@road_trip.convert_time(time_5)).to eq('2 hour(s), 46 minute(s)')
    end
  end
end
