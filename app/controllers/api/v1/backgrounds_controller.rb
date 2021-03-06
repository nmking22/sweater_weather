class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location] == ''
      output = Hash.new
      output[:error] = 'Location parameter must not be blank.'

      render json: output, :status => 400
    elsif params[:location]
      location = params[:location]
      image = ImageFacade.find_image(location)
      output = ImageSerializer.new(image)

      render json: output
    else
      output = Hash.new
      output[:error] = 'Location parameter is required.'

      render json: output, :status => 400
    end
  end
end
