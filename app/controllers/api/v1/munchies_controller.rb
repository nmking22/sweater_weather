class Api::V1::MunchiesController < ApplicationController
  def index
    road_trip_params = {
      origin: munchies_params[:start],
      destination: munchies_params[:end]
    }
    trip_and_time = RoadTripFacade.find_trip_and_time(road_trip_params)
    restaurant_query = {
      trip_and_time: trip_and_time,
      food: munchies_params[:food]
    }
    restaurant = RestaurantFacade.find_restaurant(restaurant_query)
    munchie = Munchie.new(trip_and_time[:trip], restaurant)
    output = MunchieSerializer.new(munchie)
    render json: output
  end

  private

    def munchies_params
      params.permit(:start, :end, :food)
    end
end
