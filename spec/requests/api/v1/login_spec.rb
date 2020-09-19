require 'rails_helper'

RSpec.describe 'Log In User' do
  describe 'As a authenticated user' do
    before :each do
      User.destroy_all
    end
    it "can successfully login" do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      user = User.create!(params)
      body = {
      "email": "whatever@example.com",
      "password": "password"
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(body)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:attributes][:email]).to eq(body[:email])
      expect(json[:data][:attributes][:api_key]).to_not eq(nil)
    end

    it "cannot login if email does not exist" do
      body = {
      "email": "whatever1@example.com",
      "password": "password"
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(body)

      json = JSON.parse(response.body, symbolize_names: true)

      error = { 'error': 'Email does not exists'}
      expect(json).to eq(error)
      expect(response.status).to eq(400)
    end

    it "cannot login if password does not match" do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      user = User.create!(params)
      body = {
      "email": "whatever@example.com",
      "password": "password1"
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(body)

      json = JSON.parse(response.body, symbolize_names: true)

      error = { 'error': 'Credentials are Bad' }
      expect(json).to eq(error)
      expect(response.status).to eq(400)
    end
  end
end
