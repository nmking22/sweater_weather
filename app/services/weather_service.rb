class WeatherService
  def self.find_weather_data(coordinates)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = coordinates[:lat]
      req.params['lon'] = coordinates[:lng]
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new(url: 'https://api.openweathermap.org') do |req|
        req.params['appid'] = ENV['WEATHER_KEY']
      end
    end
end
