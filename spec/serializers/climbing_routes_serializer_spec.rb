require 'rails_helper'

RSpec.describe 'Climbing routes serializer' do
  it "can serialize a ClimbingRoutesFacade" do
    crf = ClimbingRoutesFacade.new('denver,co').climbing_routes
    serialized = ClimbingRoutesSerializer.new(crf).serializable_hash
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to have_key(:location)
    expect(serialized[:data][:attributes]).to have_key(:forecast)
    expect(serialized[:data][:attributes]).to have_key(:routes)
  end
end
