class Restaurant
  attr_reader :name,
              :address

  def initialize(restaurant_data)
    @name = restaurant_data[:name]
    @address = full_address(restaurant_data[:location])
  end

  def full_address(address)
    "#{address[:address1]}, #{address[:address2]}, #{address[:city]}, #{address[:state]} #{address[:zip_code]}"
  end
end
