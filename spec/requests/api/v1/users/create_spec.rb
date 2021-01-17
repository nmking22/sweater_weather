require 'rails_helper'

describe 'users create request' do
  it 'creates a user and returns an api key' do
    payload = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: payload

    user = User.where(email: payload[:email])

    expect(response).to be_successful
    expect(response).to be_a(Hash)
    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)
    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to be_a(String)
    expect(response[:data][:type]).to eq('users')
    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(String)
    expect(response[:data][:id]).to eq(user.id.to_s)
    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)
    expect(response[:data][:attributes]).to have_key('email')
    expect(response[:data][:attributes][:email]).to be_a(String)
    expect(response[:data][:attributes][:email]).to eq(user.email)
    expect(response[:data][:attributes]).to have_key('api_key')
    expect(response[:data][:attributes][:api_key]).to be_a(String)
    expect(response[:data][:attributes][:api_key]).to eq(user.api_key)
  end
end
