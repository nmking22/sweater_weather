require 'rails_helper'

describe 'sessions create request' do
  it "returns the user's api key" do
    user = User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'abc123'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      'email': 'whatever@example.com',
      'password': 'password'
    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('users')
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data][:id]).to eq(user.id.to_s)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to be_a(String)
    expect(json[:data][:attributes][:email]).to eq(user.email)
    expect(json[:data][:attributes]).to have_key(:api_key)
    expect(json[:data][:attributes][:api_key]).to be_a(String)
    expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'a request with bad credentials returns a 400 status and error message' do
    user = User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'abc123'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      'email': 'whatever@example.com',
      'password': 'pa$$word'
    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to be_a(String)
    expect(json[:error]).to eq('Bad Credentials')
  end
end
