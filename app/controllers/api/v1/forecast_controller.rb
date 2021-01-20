class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location] == ''
      output = Hash.new
      output[:error] = 'Location parameter must not be blank.'

      render json: output, :status => 400
    elsif params[:location]
      location = params[:location]
      forecast = ForecastFacade.find_forecast(location)
      output = ForecastSerializer.new(forecast)

      render json: output
    else
      output = Hash.new
      output[:error] = 'Location parameter is required.'

      render json: output, :status => 400
    end
  end
end
