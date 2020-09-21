class Image
  attr_reader :id,
              :location,
              :image_url,
              :credit

  def initialize(image_params)
    @location = image_params[:location]
    @image_url = image_params[:image_url]
    @credit = image_params[:credit]
  end
end
