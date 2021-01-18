require 'rails_helper'

describe 'location service' do
  describe 'class methods' do
    it 'find_location_data' do
      location = 'new orleans,la'
      data = LocationService.find_location_data(location)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:results)
      expect(data[:results]).to be_an(Array)
      expect(data[:results][0]).to be_a(Hash)
      expect(data[:results][0]).to have_key(:locations)
      expect(data[:results][0][:locations]).to be_an(Array)
      expect(data[:results][0][:locations][0]).to have_key(:latLng)
      expect(data[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(data[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(data[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(data[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end

    it 'find_trip_data' do
      params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "abc123"
      }

      trip_data = LocationService.find_trip_data(params)

      expect(trip_data).to be_a(Hash)
      expect(trip_data).to have_key(:route)
      expect(trip_data[:route]).to be_a(Hash)
      expect(trip_data[:route]).to have_key(:realTime)
      expect(trip_data[:route][:realTime]).to be_an(Integer)
    end
  end
end
