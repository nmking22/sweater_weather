require 'rails_helper'

describe 'users create request' do
  it 'creates a user and returns an api key' do
    payload = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    # headers = {
    #   'Content_Type' => 'application/json',
    #   'Accept' =>    'application/json'
    # }
    #
    # post '/api/v1/users', headers: headers, params: JSON.generate(payload)

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    user = User.find_by(email: payload[:email])

    expect(response).to be_successful
    expect(response.status).to eq(201)
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

    expect(json[:data][:attributes]).to_not have_key(:password)
    expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
    expect(json[:data][:attributes]).to_not have_key(:password_digest)
  end

  it 'returns 400 error with descriptive body if email already is in database' do
    user = User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'abc123'
    )

    payload = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq('Email has already been taken')
  end

  it 'returns 400 error with descriptive body if password and confirmation do not match' do
    payload = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "pa$$word"
    }

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'returns 400 error with descriptive body if email field is missing' do
    payload = {
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Email can't be blank")
  end

  it 'returns 400 error with descriptive body if password field is missing' do
    payload = {
      "email": "whatever@example.com",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password can't be blank")
  end

  it 'returns 400 error with descriptive body if password_confirmation field is missing' do
    payload = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post '/api/v1/users', params: payload

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password confirmation can't be blank")
  end
end
