class RestaurantFacade
  def self.find_restaurant(restaurant_query)
    RestaurantService.find_restaurant_data(restaurant_query)
    # binding.pry
  end
end
