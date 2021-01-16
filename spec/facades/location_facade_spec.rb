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
  end
end
