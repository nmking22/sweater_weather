class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :end_city, :start_city, :travel_time, :weather_at_eta
end
