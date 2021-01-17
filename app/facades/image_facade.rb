class ImageFacade
  def self.find_image(location)
    image_info = ImageService.find_image_info(location)
    Image.new(image_info, location)
  end
end
