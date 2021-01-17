require 'rails_helper'

describe 'current weather' do
  it 'has readable attributes' do
    data = {
      :dt=>1610844558,
      :sunrise=>1610806713,
      :sunset=>1610841641,
      :temp=>36.88,
      :feels_like=>30.81,
      :pressure=>1020,
      :humidity=>51,
      :dew_point=>21.76,
      :uvi=>0,
      :clouds=>9,
      :visibility=>10000,
      :wind_speed=>1.99,
      :wind_deg=>74,
      :wind_gust=>5.99,
      :weather=>
        [{:id=>800,
          :main=>"Clear",
          :description=>"clear sky",
          :icon=>"01n"}]}

    weather = CurrentWeather.new(data)

    expect(weather.datetime).to eq('2021-01-17 12:49:18 +0000')
    expect(weather.sunrise).to eq('2021-01-16 02:18:33 +0000')
    expect(weather.sunset).to eq('2021-01-17 12:00:41 +0000')
    expect(weather.temperature).to eq(36.9)
    expect(weather.feels_like).to eq(30.8,)
    expect(weather.humidity).to eq(51)
    expect(weather.uvi).to eq(0)
    expect(weather.visibility).to eq(10000)
    expect(weather.conditions).to eq('clear sky')
    expect(weather.icon).to eq('01n')
  end
end
