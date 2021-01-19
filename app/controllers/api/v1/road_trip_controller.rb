class Api::V1::RoadTripController < ApplicationController
  def create
    if road_trip_params[:origin] == nil
      output = Hash.new
      output[:error] = 'Origin is required.'

      render json: output, :status => 400
    elsif road_trip_params[:destination] == nil
      output = Hash.new
      output[:error] = 'Destination is required.'

      render json: output, :status => 400
    elsif User.find_by(api_key: road_trip_params[:api_key])
      road_trip = RoadTripFacade.find_road_trip(road_trip_params)
      output = RoadtripSerializer.new(road_trip)

      render json: output
    elsif road_trip_params[:api_key]
      output = Hash.new
      output[:error] = 'Invalid API key.'

      render json: output, :status => 401
    else
      output = Hash.new
      output[:error] = 'API key is required.'

      render json: output, :status => 400
    end
  end

  private

    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end
