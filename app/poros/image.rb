class Image
  attr_reader :id,
              :image

  def initialize(data, location)
    @id = 'null'
    @image = {
      location: location,
      image_url: data[:urls][:full],
      credit: {
        source: 'Unsplash',
        author: data[:user][:name]
      }
    }
  end
end
