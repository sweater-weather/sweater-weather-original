class ImageFacade

  def initialize(location_param)
    @location_param = location_param
  end

  def image
    data = {
      location: @location_param,
      image_url: image_service[:urls][:raw],
      credit: credits
    }
    Image.new(data)
  end

  private

  def image_service
    ImageService.new.image(@location_param)
  end

  def credits
    {
      source: 'https://unsplash.com/',
      author: image_service[:user][:username],
      logo: 'https://unsplash-assets.imgix.net/marketing/press-symbol.svg?auto=format&fit=crop&q=60'
    }
  end
end
