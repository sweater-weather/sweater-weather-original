require 'rails_helper'

RSpec.describe UserSerializer do
  it "can serialize a user" do
    params = {
      "email": "whateverexit@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    user = User.create!(params)
    expected = {
      "data": {
          "id": "9",
          "type": "users",
          "attributes": {
              "email": "whatever63@example.com",
              "api_key": "9d_P64qZffiRU_xpdYYuHg"
          }
      }
    }
    json = UserSerializer.new(user).serializable_hash
    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes]).to have_key(:api_key)
  end
end
