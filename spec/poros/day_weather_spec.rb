require 'rails_helper'

describe 'day weather' do
  it 'has readable attributes' do
    data = {
      :dt=>1610823600,
      :sunrise=>1610806713,
      :sunset=>1610841641,
      :temp=>
        {:day=>42.4,
         :min=>33.85,
         :max=>43.92,
         :night=>34.59,
         :eve=>37.67,
         :morn=>33.85},
      :feels_like=>
        {:day=>35.64,
         :night=>29.8,
         :eve=>30.74,
         :morn=>28.29},
      :pressure=>1020,
      :humidity=>61,
      :dew_point=>24.01,
      :wind_speed=>5.14,
      :wind_deg=>137,
      :weather=>
        [{:id=>800,
          :main=>"Clear",
          :description=>"clear sky",
          :icon=>"01d"}],
      :clouds=>0,
      :pop=>0.16,
      :uvi=>1.9}

    weather = DayWeather.new(data)

    expect(weather.date).to eq('2021-01-16')
    expect(weather.sunrise).to eq("2021-01-16 02:18:33 +0000")
    expect(weather.sunset).to eq("2021-01-17 12:00:41 +0000")
    expect(weather.max_temp).to eq(43.9)
    expect(weather.min_temp).to eq(33.9)
    expect(weather.conditions).to eq('clear sky')
    expect(weather.icon).to eq('01d')
  end
end
