class RestaurantFacade
  def self.find_restaurant(restaurant_query)
    restaurant_data = RestaurantService.find_restaurant_data(restaurant_query)
    Restaurant.new(restaurant_data)
  end
end
