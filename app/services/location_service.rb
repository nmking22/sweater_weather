class LocationService
  def self.find_location_data(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new('http://www.mapquestapi.com')
    end
end
