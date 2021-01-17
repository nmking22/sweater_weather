require 'rails_helper'

describe 'image service' do
  describe 'class methods' do
    it 'find_image_info' do
      location = 'new orleans,la'
      json = ImageService.find_image_info(location)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:urls)
      expect(json[:urls]).to be_a(Hash)
      expect(json[:urls]).to have_key(:full)
      expect(json[:urls][:full]).to be_a(String)
      expect(json).to have_key(:user)
      expect(json[:user]).to be_a(Hash)
      expect(json[:user]).to have_key(:name)
    end
  end
end
