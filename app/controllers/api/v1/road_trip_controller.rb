class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip = RoadTripFacade.find_road_trip(road_trip_params)
    output = RoadtripSerializer.new(road_trip)

    render json: output
  end

  private

    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end
