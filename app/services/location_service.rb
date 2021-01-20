class LocationService
  def self.find_location_data(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_trip_data(params)
    response = conn.get('/directions/v2/route') do |req|
      req.params['from'] = params[:origin]
      req.params['to'] = params[:destination]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new(url: 'http://www.mapquestapi.com') do |req|
        req.params['key'] = ENV['MAPQUEST_KEY']
      end
    end
end
