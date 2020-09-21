require 'rails_helper'

RSpec.describe 'Forecast endpoint', :vcr do
  it "can make a get request for the forecast endpoint" do
    VCR.use_cassette('/Forecast_endpoint/can_make_a_get_request_for_the_forecast_endpoint') do
      params = {
        location: 'denver,co'
      }
      headers = {
        'content-type': 'application/json',
        'Accept': 'application/json'
      }

      get '/api/v1/forecast', headers: headers, params: params

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')

      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to have_key(:location)
      expect(forecast[:data][:attributes]).to have_key(:current_forecast)
      expect(forecast[:data][:attributes]).to have_key(:weekly_forecast)
      expect(forecast[:data][:attributes]).to have_key(:hourly_forecast)

      location_keys = [:city, :state, :country, :country_name]
      location_keys.each do |key|
        expect(forecast[:data][:attributes][:location]).to have_key(key)
      end

      current_forecast_keys = [:description, :current_weather, :icon, :high, :low, :date_time, :date_time_formatted, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunrise_time, :sunset, :sunset_time]
      current_forecast_keys.each do |key|
        expect(forecast[:data][:attributes][:current_forecast]).to have_key(key)
      end

      weekly_forecast_keys = [:description, :icon, :date_time, :weekday, :high, :low, :snow_percipitation, :rain_percipitation]
      weekly_forecast_keys.each do |key|
        expect(forecast[:data][:attributes][:weekly_forecast][0]).to have_key(key)
      end

      hourly_forecast_keys = [:temperature, :date_time, :date_time_formatted, :icon]
      hourly_forecast_keys.each do |key|
        expect(forecast[:data][:attributes][:hourly_forecast][0]).to have_key(key)
      end
    end
  end

  it "cannot make request with empty parameters" do
    VCR.use_cassette('/Forecast_endpoint/can_make_a_get_request_for_the_forecast_endpoint') do
      params = {
        location: ''
      }
      headers = {
        'content-type': 'application/json',
        'Accept': 'application/json'
      }

      get '/api/v1/forecast', headers: headers, params: params

      background = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(background).to eq({ 'errors': 'No location specified' })
    end
  end

  it "cannot make request with no parameters" do
    VCR.use_cassette('/Forecast_endpoint/can_make_a_get_request_for_the_forecast_endpoint') do
      headers = {
        'content-type': 'application/json',
        'Accept': 'application/json'
      }

      get '/api/v1/forecast', headers: headers

      background = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(background).to eq({ 'errors': 'No location specified' })
    end
  end
end
