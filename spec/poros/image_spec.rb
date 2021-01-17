require 'rails_helper'

describe 'image' do
  it 'has readable attributes' do
    data = {
      urls: {
        full: 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkxNzd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=85'
      },
      user: {
        name: 'Michael Kilcoynes'
      }
    }
    location = 'new orleans,la'
    image = Image.new(data, location)

    expect(image.id).to eq('null')
    expect(image.image).to be_a(Hash)
    expect(image.image).to have_key(:location)
    expect(image.image[:location]).to eq('new orleans,la')
    expect(image.image[:location]).to be_a(String)
    expect(image.image).to have_key(:image_url)
    expect(image.image[:image_url]).to be_a(String)
    expect(image.image).to have_key(:credit)
    expect(image.image[:credit]).to be_a(Hash)
    expect(image.image[:credit]).to have_key(:source)
    expect(image.image[:credit][:source]).to eq('Unsplash')
    expect(image.image[:credit][:source]).to be_a(String)
    expect(image.image[:credit]).to have_key(:author)
    expect(image.image[:credit][:author]).to be_a(String)
  end
end
