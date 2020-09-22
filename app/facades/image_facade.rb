class ImageFacade

  def initialize(location_param)
    @location_param = location_param
    @city = location_param.split(',')[0]
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
    ImageService.new.image(@city)
  end

  def credits
    {
      source: 'https://unsplash.com/',
      author: image_service[:user][:username],
      logo: 'https://unsplash-assets.imgix.net/marketing/press-symbol.svg?auto=format&fit=crop&q=60'
    }
  end
end
