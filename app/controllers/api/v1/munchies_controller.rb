class Api::V1::MunchiesController < ApplicationController
  def index
    if restaurant == 'impossible'
      output = Hash.new
      output[:error] = 'Queried trip is not possible.'
      
      render json: output, :status => 400
    else
      munchie = Munchie.new(trip_and_time[:trip], restaurant)
      output = MunchieSerializer.new(munchie)

      render json: output
    end
  end

  def trip_and_time
    road_trip_params = {
      origin: munchies_params[:start],
      destination: munchies_params[:end]
    }
    RoadTripFacade.find_trip_and_time(road_trip_params)
  end

  def restaurant
    if trip_and_time[:time] == 'impossible'
      return 'impossible'
    else
      restaurant_query = {
        trip_and_time: trip_and_time,
        food: munchies_params[:food]
      }
      RestaurantFacade.find_restaurant(restaurant_query)
    end
  end

  private

    def munchies_params
      params.permit(:start, :end, :food)
    end
end
