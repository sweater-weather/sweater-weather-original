require 'rails_helper'

RSpec.describe ImageSerializer do
  it "can serialize an image" do
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

    serialized = ImageSerializer.new(i).serializable_hash

    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:attributes]).to have_key(:location)
    expect(serialized[:data][:attributes]).to have_key(:image_url)
    expect(serialized[:data][:attributes]).to have_key(:credit)
    expect(serialized[:data][:attributes][:credit]).to have_key(:source)
    expect(serialized[:data][:attributes][:credit]).to have_key(:author)
    expect(serialized[:data][:attributes][:credit]).to have_key(:logo)
  end
end
