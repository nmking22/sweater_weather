require 'rails_helper'

describe 'image facade' do
  describe 'class methods' do
    it 'find_image_info' do
      location = 'new orleans,la'
      image = ImageFacade.find_image(location)

      expect(image).to be_an(Image)
      expect(image.image[:location]).to eq('new orleans,la')
    end
  end
end
