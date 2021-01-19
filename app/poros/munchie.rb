class Munchie
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(road_trip, restaurant)
    @id = 'null'
    @destination_city = road_trip.end_city
    @travel_time = road_trip.travel_time
    @forecast = hash_forecast(road_trip.weather_at_eta)
    @restaurant = restaurant
  end

  def hash_forecast(weather)
    {
      summary: weather.conditions,
      temperature: weather.temperature.round.to_s
    }
  end
end
