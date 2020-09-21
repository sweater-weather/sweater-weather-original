require 'rails_helper'

RSpec.describe 'Climbing routes' do
  it "can get climbing routes requests" do
    params = {
      location: 'denver,co'
    }

    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/climbing_routes', headers: headers, params: params
    # params could also be passed as JSON.generate(params), but we're passing these not through the body?
    climbing_routes = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    expect(climbing_routes).to have_key(:data)
    expect(climbing_routes[:data]).to have_key(:id)
    expect(climbing_routes[:data]).to have_key(:type)
    expect(climbing_routes[:data][:type]).to eq('climbing route')
    expect(climbing_routes[:data]).to have_key(:attributes)
    expect(climbing_routes[:data][:attributes]).to have_key(:location)
    expect(climbing_routes[:data][:attributes]).to have_key(:forecast)
    expect(climbing_routes[:data][:attributes]).to have_key(:routes)
    expect(climbing_routes[:data][:attributes][:location]).to eq(params[:location])
    expect(climbing_routes[:data][:attributes][:forecast]).to have_key(:summary)
    expect(climbing_routes[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(climbing_routes[:data][:attributes][:routes][0]).to have_key(:name)
    expect(climbing_routes[:data][:attributes][:routes][0]).to have_key(:type)
    expect(climbing_routes[:data][:attributes][:routes][0]).to have_key(:rating)
    expect(climbing_routes[:data][:attributes][:routes][0]).to have_key(:location)
    expect(climbing_routes[:data][:attributes][:routes][0]).to have_key(:distance_to_route)
  end
end
