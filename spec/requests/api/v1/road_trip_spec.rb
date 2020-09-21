require 'rails_helper'

RSpec.describe 'RoadTrip Endpoint', :vcr do
  it "can post a request" do
    VCR.use_cassette('/RoadTrip_Endpoint/can_post_a_request') do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      user = User.create!(params)
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": user.api_key
      }
      post '/api/v1/road_trip', params: JSON.generate(body), headers: headers

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data][:type]).to eq('road_trip_forecast')
      expect(road_trip[:data]).to have_key(:attributes)
      keys = [:origin, :destination, :travel_time, :travel_time_formatted, :arrival_forecast]
      keys.each do |key|
        expect(road_trip[:data][:attributes]).to have_key(key)
      end
      expect(road_trip[:data][:attributes][:arrival_forecast]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:arrival_forecast]).to have_key(:description)
    end
  end

  it "cannot return info if api is invalid or does not exist" do
    VCR.use_cassette('/RoadTrip_Endpoint/can_post_a_request') do
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post '/api/v1/road_trip', params: JSON.generate(body), headers: headers

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(response.status). to eq(400)
      expect(road_trip).to eq({ 'error': 'Api Key does not exist' })
    end
  end
end
