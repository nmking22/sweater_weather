require 'rails_helper'

describe 'weather at eta' do
  before :each do
    json_data = File.read('spec/fixtures/weather_data.json')

    @data = JSON.parse(json_data, symbolize_names: true)

    @time = 260000
    @time_2 = 10
    @time_3 = 5000
    @time_4 = 100000
    @time_5 = 10000

    @weather = WeatherAtEta.new(@data, @time)
  end

  it 'has readable attributes' do
    expect(@weather.temperature).to eq(69.4)
    expect(@weather.conditions).to eq('broken clouds')
  end

  describe 'class methods' do
    it 'find_temp' do
      expect(@weather.find_temp(@data, @time)).to eq(69.4)
      expect(@weather.find_temp(@data, @time_2)).to eq(61.5)
      expect(@weather.find_temp(@data, @time_3)).to eq(60.7)
      expect(@weather.find_temp(@data, @time_4)).to eq(69.2)
      expect(@weather.find_temp(@data, @time_5)).to eq(60.9)
    end

    it 'find_conditions' do
      expect(@weather.find_conditions(@data, @time)).to eq('broken clouds')
      expect(@weather.find_conditions(@data, @time_2)).to eq('clear sky')
      expect(@weather.find_conditions(@data, @time_3)).to eq('clear sky')
      expect(@weather.find_conditions(@data, @time_4)).to eq('few clouds')
      expect(@weather.find_conditions(@data, @time_5)).to eq('clear sky')
    end

    it 'find_time_key' do
      expect(@weather.find_time_key(@time)).to eq([:daily, 3])
      expect(@weather.find_time_key(@time_2)).to eq([:hourly, 0])
      expect(@weather.find_time_key(@time_3)).to eq([:hourly, 1])
      expect(@weather.find_time_key(@time_4)).to eq([:hourly, 27])
      expect(@weather.find_time_key(@time_5)).to eq([:hourly, 2])
    end
  end
end
