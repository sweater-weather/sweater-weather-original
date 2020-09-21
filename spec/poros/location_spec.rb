require 'rails_helper'

RSpec.describe Location do
  it "can create a Location" do
    data = {:city=>"Denver", :state=>"CO", :country=>"US"}
    l = Location.new(data)
    expect(l.city).to eq(data[:city])
    expect(l.state).to eq(data[:state])
    expect(l.country).to eq(data[:country])
    expect(l.country_name).to eq(ISO3166::Country.new(data[:country]).data['unofficial_names'][0])
  end
end
