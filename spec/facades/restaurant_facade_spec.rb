require 'rails_helper'

describe 'restaurant facade' do
  describe 'class methods' do
    it 'find_restaurant' do
      json_data = File.read('spec/fixtures/weather_data.json')
      data = JSON.parse(json_data, symbolize_names: true)
      time = 260000
      weather = WeatherAtEta.new(data, time)
      trip = RoadTrip.new(time, 'denver,co', 'buffalo,ny', weather)

      query = {
        trip_and_time: {
          trip: trip,
          time: 6658
        },
        food: 'chinese'
      }

      restaurant = RestaurantFacade.find_restaurant(query)

      expect(restaurant).to be_a(Restaurant)
    end
  end
end
