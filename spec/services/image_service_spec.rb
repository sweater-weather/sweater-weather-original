require 'rails_helper'

RSpec.describe 'Image Service', :vcr do
  it "can get image" do
    VCR.use_cassette('/Image_Service/can_get_image.yml') do
      keys = [:id, :created_at, :updated_at, :promoted_at, :width, :height, :color, :description, :alt_description, :urls, :categories, :likes, :liked_by_user, :current_user_collections, :sponsorship, :user]
      image_data = ImageService.new.image('Denver,CO')
      keys.each do |key|
        expect(image_data).to have_key(key)
      end
      expect(image_data[:urls]).to have_key(:raw)
      expect(image_data[:user]).to have_key(:username)
    end
  end
end
