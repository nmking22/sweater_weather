class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: road_trip_params[:api_key])
      road_trip = RoadTripFacade.find_road_trip(road_trip_params)
      output = RoadtripSerializer.new(road_trip)

      render json: output
    else
      output = Hash.new
      output[:error] = 'Invalid API key.'
      render json: output, :status => 401
    end
  end

  private

    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end
