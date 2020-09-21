require 'rails_helper'

RSpec.describe 'User' do
  before :each do
    User.destroy_all
  end
  it "can post to users" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response).to be_successful

    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json')
    user = User.last
    expect(user.email).to eq(params[:email])
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:type]).to eq('users')
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:attributes][:email]).to eq(params[:email])
    expect(json[:data][:attributes]).to have_key(:api_key)
  end

  it "returns a fields cannot be blank error if email is left blank" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "",
      "password": "password",
      "password_confirmation": "password"
    }

    error = { 'error': 'Fields cannot be blank' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "returns a fields cannot be blank error if password is left blank" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "",
      "password_confirmation": "password"
    }

    error = { 'error': 'Fields cannot be blank' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "returns a fields cannot be blank error if password confirmation is left blank" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": ""
    }

    error = { 'error': 'Fields cannot be blank' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "returns a fields cannot be blank error if all fields are left blank" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "",
      "password": "",
      "password_confirmation": ""
    }

    error = { 'error': 'Fields cannot be blank' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "Emails must be unique" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    user = User.create!(params)

    error = { 'error': 'Email has already been taken' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "Passwords must match" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password1",
      "password_confirmation": "password"
    }

    error = { 'error': 'Passwords do not match' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end

  it "Password confirmation must match" do
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password1"
    }

    error = { 'error': 'Passwords do not match' }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    r = JSON.parse(response.body, symbolize_names: true)

    expect(r).to eq(error)
    expect(response.status).to eq(400)
  end
end
