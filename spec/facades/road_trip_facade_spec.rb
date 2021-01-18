require 'rails_helper'

describe 'road trip facade' do
  describe 'class methods' do
    it 'find_road_trip' do
      params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "abc123"
      }

      road_trip = RoadTripFacade.find_road_trip(params)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(WeatherAtEta)
    end
  end
end
