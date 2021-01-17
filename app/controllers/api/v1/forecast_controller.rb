class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    forecast = ForecastFacade.find_forecast(location)
    output = ForecastSerializer.new(forecast)

    render json: output
  end
end
