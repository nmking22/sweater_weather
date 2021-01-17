class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]
    image = ImageFacade.find_image(location)
    output = ImageSerializer.new(image)

    render json: output
  end
end
