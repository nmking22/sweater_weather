require 'date'

class RestaurantService
  def self.find_restaurant_data(restaurant_query)
    travel_time = restaurant_query[:trip_and_time][:time]
    eta = RestaurantService.convert_time(travel_time)
    response = conn.get('/v3/businesses/search') do |req|
      req.headers['Authorization'] = ENV['YELP_KEY']
      req.params['term'] = restaurant_query[:food]
      req.params['open_at'] = eta
      req.params['location'] = restaurant_query[:trip_and_time][:trip].end_city
    end
    JSON.parse(response.body, symbolize_names: true)[:businesses][0]
  end

  def self.convert_time(travel_time)
    time_now = Time.now.to_time.to_i
    time_now + travel_time
  end

  private

    def self.conn
      Faraday.new('https://api.yelp.com')
    end
end
