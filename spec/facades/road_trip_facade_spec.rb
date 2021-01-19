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

    it 'find_trip_and_time' do
      params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO"
      }

      trip_and_time = RoadTripFacade.find_trip_and_time(params)

      expect(trip_and_time).to be_a(Hash)
      expect(trip_and_time.keys).to eq([:trip, :time])
      expect(trip_and_time[:trip]).to be_a(RoadTrip)
      expect(trip_and_time[:time]).to be_an(Integer)
    end

    it 'find_trip_and_time sad path' do
      params = {
        origin: "Denver,CO",
        destination: "London,UK"
      }

      trip_and_time = RoadTripFacade.find_trip_and_time(params)

      expect(trip_and_time).to be_a(Hash)
      expect(trip_and_time.keys).to eq([:trip, :time])
      expect(trip_and_time[:trip]).to be_a(RoadTrip)
      expect(trip_and_time[:trip].travel_time).to eq('impossible')
      expect(trip_and_time[:trip].weather_at_eta).to eq(nil)
      expect(trip_and_time[:time]).to be_a(String)
      expect(trip_and_time[:time]).to eq('impossible')
    end
  end
end
