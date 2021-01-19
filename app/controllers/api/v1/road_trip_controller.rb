class Api::V1::RoadTripController < ApplicationController
  def create
    if road_trip_params[:origin] == nil
      origin_error
    elsif road_trip_params[:destination] == nil
      destination_error
    elsif User.find_by(api_key: road_trip_params[:api_key])
      successful_response
    elsif road_trip_params[:api_key]
      invalid_api_error
    else
      missing_api_error
    end
  end

  def successful_response
    road_trip = RoadTripFacade.find_road_trip(road_trip_params)
    output = RoadtripSerializer.new(road_trip)

    render json: output
  end

  def origin_error
    output = Hash.new
    output[:error] = 'Origin is required.'

    render json: output, :status => 400
  end

  def destination_error
    output = Hash.new
    output[:error] = 'Destination is required.'

    render json: output, :status => 400
  end

  def invalid_api_error
    output = Hash.new
    output[:error] = 'Invalid API key.'

    render json: output, :status => 401
  end

  def missing_api_error
    output = Hash.new
    output[:error] = 'API key is required.'

    render json: output, :status => 400
  end

  private

    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end
