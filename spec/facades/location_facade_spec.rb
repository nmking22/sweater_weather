require 'rails_helper'

describe 'location facade' do
  describe 'class methods' do
    it 'find_coordinates' do
      location = 'new orleans,la'
      coordinates = LocationFacade.find_coordinates(location)

      expect(coordinates).to be_a(Hash)
      expect(coordinates).to have_key(:lat)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates).to have_key(:lng)
      expect(coordinates[:lng]).to be_a(Float)
    end

    it 'find_coordinates international locations' do
      location_1 = 'london,uk'
      location_2 = 'frankfurt,de'
      coordinates_1 = LocationFacade.find_coordinates(location_1)
      coordinates_2 = LocationFacade.find_coordinates(location_2)

      expect(coordinates_1).to be_a(Hash)
      expect(coordinates_1).to have_key(:lat)
      expect(coordinates_1[:lat]).to be_a(Float)
      expect(coordinates_1).to have_key(:lng)
      expect(coordinates_1[:lng]).to be_a(Float)

      expect(coordinates_2).to be_a(Hash)
      expect(coordinates_2).to have_key(:lat)
      expect(coordinates_2[:lat]).to be_a(Float)
      expect(coordinates_2).to have_key(:lng)
      expect(coordinates_2[:lng]).to be_a(Float)
    end

    it 'find_coordinates full address' do
      location_1 = '1331 17th St LL100, Denver, CO 80202'
      location_2 = '1600 Pennsylvania Avenue NW, Washington, DC 20500'
      coordinates_1 = LocationFacade.find_coordinates(location_1)
      coordinates_2 = LocationFacade.find_coordinates(location_2)

      expect(coordinates_1).to be_a(Hash)
      expect(coordinates_1).to have_key(:lat)
      expect(coordinates_1[:lat]).to be_a(Float)
      expect(coordinates_1).to have_key(:lng)
      expect(coordinates_1[:lng]).to be_a(Float)

      expect(coordinates_2).to be_a(Hash)
      expect(coordinates_2).to have_key(:lat)
      expect(coordinates_2[:lat]).to be_a(Float)
      expect(coordinates_2).to have_key(:lng)
      expect(coordinates_2[:lng]).to be_a(Float)
    end
  end
end
