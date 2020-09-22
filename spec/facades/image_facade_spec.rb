require 'rails_helper'

RSpec.describe ImageFacade do
  it "can create an Image", :vcr do
    VCR.use_cassette('/ImageFacade/can_create_an_Image') do
      image = ImageFacade.new('denver,co').image
      expect(image).to be_an_instance_of(Image)
    end
  end
end
