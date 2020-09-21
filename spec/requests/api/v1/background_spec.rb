require 'rails_helper'

RSpec.describe 'Background Endpoint' do
  it "can make a get request for a background endpoint" do
    params = {
      location: 'denver,co'
    }
    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/backgrounds', headers: headers, params: params

    background = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    expect(background).to have_key(:data)
    expect(background[:data]).to have_key(:id)
    expect(background[:data]).to have_key(:type)
    expect(background[:data][:type]).to eq('image')
    expect(background[:data]).to have_key(:attributes)
    expect(background[:data][:attributes]).to have_key(:location)
    expect(background[:data][:attributes]).to have_key(:image_url)
    expect(background[:data][:attributes]).to have_key(:credit)
    expect(background[:data][:attributes][:credit]).to have_key(:source)
    expect(background[:data][:attributes][:credit]).to have_key(:author)
    expect(background[:data][:attributes][:credit]).to have_key(:logo)
  end

  it "cannot make request with empty parameters" do
    params = {
      location: ''
    }
    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/backgrounds', headers: headers, params: params

    background = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(background).to eq({ 'errors': 'No location specified' })
  end

  it "cannot make request with no parameters" do
    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/backgrounds', headers: headers

    background = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(background).to eq({ 'errors': 'No location specified' })
  end
end
