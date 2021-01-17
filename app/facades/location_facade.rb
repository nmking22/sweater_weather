class LocationFacade
  def self.find_coordinates(location)
    location_data = LocationService.find_location_data(location)
    location_data[:results][0][:locations][0][:latLng]
  end
end
