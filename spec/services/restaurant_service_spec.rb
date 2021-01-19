require 'rails_helper'

describe 'restaurant service' do
  describe 'class methods' do
    before :each do
      json_data = File.read('spec/fixtures/weather_data.json')
      data = JSON.parse(json_data, symbolize_names: true)
      time = 260000
      weather = WeatherAtEta.new(data, time)
      trip = RoadTrip.new(time, 'denver,co', 'buffalo,ny', weather)

      @query = {
        trip_and_time: {
          trip: trip,
          time: 6658
        },
        food: 'chinese'
      }
    end

    it 'find_restaurant_data' do
      restaurant_data = RestaurantService.find_restaurant_data(@query)

      expect(restaurant_data).to be_a(Hash)
      expect(restaurant_data).to have_key(:name)
      expect(restaurant_data[:name]).to be_a(String)
      expect(restaurant_data).to have_key(:location)
      expect(restaurant_data[:location]).to be_a(Hash)
      expect(restaurant_data[:location]).to have_key(:address1)
      expect(restaurant_data[:location][:address1]).to be_a(String)
      expect(restaurant_data[:location]).to have_key(:address2)
      expect(restaurant_data[:location][:address2]).to be_a(String)
      expect(restaurant_data[:location]).to have_key(:city)
      expect(restaurant_data[:location][:city]).to be_a(String)
      expect(restaurant_data[:location]).to have_key(:state)
      expect(restaurant_data[:location][:state]).to be_a(String)
      expect(restaurant_data[:location]).to have_key(:zip_code)
      expect(restaurant_data[:location][:zip_code]).to be_a(String)
    end

    it 'convert_time' do
      travel_time = @query[:trip_and_time][:time]

      expect(RestaurantService.convert_time(travel_time)).to be_an(Integer)
    end
  end
end
