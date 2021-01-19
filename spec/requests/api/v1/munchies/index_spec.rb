require 'rails_helper'

describe 'muchies request' do
  it 'returns destination city, travel time, forecast and restaurant' do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    # tests hashes only have wanted keys
    data_keys = [:id, :type, :attributes]
    attribute_keys = [:destination_city, :travel_time, :forecast, :restaurant]
    forecast_keys = [:summary, :temperature]
    restaurant_keys = [:name, :address]

    expect(json.keys).to eq([:data])
    expect(json[[:data]].keys).to eq(data_keys)
    expect(json[[:data][:attributes]].keys).to eq(attribute_keys)
    expect(json[[:data][:forecast]].keys).to eq(forecast_keys)
    expect(json[[:data][:restaurant]].keys).to eq(restaurant_keys)

    # tests data types/known values of hash values
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq('null')
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('munchie')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)

    expect(json[:data][:attributes]).to have_key(:destination_city)
    expect(json[:data][:attributes][:destination_city]).to be_a(String)
    expect(json[:data][:attributes][:destination_city]).to eq('Pueblo, CO')
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:forecast)
    expect(json[:data][:attributes][:forecast]).to be_a(Hash)
    expect(json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)
    expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(json[:data][:attributes][:forecast][:temperature]).to be_a(String)

    expect(json[:data][:attributes]).to have_key(:restaurant)
    expect(json[:data][:attributes][:restaurant]).to be_a(Hash)
    expect(json[:data][:attributes][:restaurant]).to have_key(:name)
    expect(json[:data][:attributes][:restaurant][:name]).to be_a(String)
    expect(json[:data][:attributes][:restaurant]).to have_key(:address)
    expect(json[:data][:attributes][:restaurant][:address]).to be_a(String)

  end
end
