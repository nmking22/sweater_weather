require 'rails_helper'

describe 'road trip create request' do
  it "returns road trip info for the payload" do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    # tests only wanted keys exist
    expect(json.keys).to eq([:data])
    expect(json[:data].keys).to eq([:id, :type, :attributes])
    expect(json[:data][:attributes].keys).to eq([:end_city, :start_city, :travel_time, :weather_at_eta])

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('roadtrip')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to eq('Denver, CO')
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to eq('Pueblo, CO')
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'returns 401 error if api key is invalid' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "bad key"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(401)

    expect(json).to be_a(Hash)
    expect(json.keys).to eq([:error])
    expect(json[:error]).to be_a(String)
    expect(json[:error]).to eq('Invalid API key.')
  end

  it 'returns 400 error if api key is not included in body of request' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json.keys).to eq([:error])
    expect(json[:error]).to be_a(String)
    expect(json[:error]).to eq('API key is required.')
  end

  it 'returns 400 error if origin is not included in body of request' do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json.keys).to eq([:error])
    expect(json[:error]).to be_a(String)
    expect(json[:error]).to eq('Origin is required.')
  end

  it 'returns 400 error if destination is not included in body of request' do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "origin": "Denver,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    expect(json).to be_a(Hash)
    expect(json.keys).to eq([:error])
    expect(json[:error]).to be_a(String)
    expect(json[:error]).to eq('Destination is required.')
  end

  it "response for impossible road trips has empty weather block and 'impossible' travel_time" do
    User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    )

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    payload = {
      "origin": "New York,NY",
      "destination": "London,UK",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(payload)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    # tests only wanted keys exist
    expect(json.keys).to eq([:data])
    expect(json[:data].keys).to eq([:id, :type, :attributes])
    expect(json[:data][:attributes].keys).to eq([:end_city, :start_city, :travel_time, :weather_at_eta])

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data][:type]).to eq('roadtrip')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to eq('New York, NY')
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to eq('London, UK')
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes][:travel_time]).to eq('impossible')
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to eq(nil)
  end
end
