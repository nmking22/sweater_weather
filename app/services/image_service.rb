class ImageService
  def self.find_image_info(location)
    response = conn.get('/search/photos') do |req|
      req.params['query'] = location
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0]
  end

  private

    def self.conn
      Faraday.new(url: 'https://api.unsplash.com') do |req|
        req.params['client_id'] = ENV['UNSPLASH_KEY']
      end
    end
end
