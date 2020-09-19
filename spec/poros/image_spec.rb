require 'rails_helper'

RSpec.describe Image do
  it "can create an Image" do
    data = {
      :location=>"denver,co",
      :image_url=>"https://images.unsplash.com/photo-1570585429632-e8b74372a3ed?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE2NzI1Mn0",
      :credit=> {
        :source=>"https://unsplash.com/",
        :author=>"melissamullinator",
        :logo=>"https://unsplash-assets.imgix.net/marketing/press-symbol.svg?auto=format&fit=crop&q=60"
      }
    }
    i = Image.new(data)
    expect(i.location).to eq(data[:location])
    expect(i.image_url).to eq(data[:image_url])
    expect(i.credit).to eq(data[:credit])
  end
end
