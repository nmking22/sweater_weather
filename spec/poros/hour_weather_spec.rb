require 'rails_helper'

describe 'hour weather' do
  it 'has readable attributes' do
    data = {
      :dt=>1610845200,
      :temp=>36.07,
      :feels_like=>28.63,
      :pressure=>1020,
      :humidity=>52,
      :dew_point=>21.51,
      :uvi=>0,
      :clouds=>93,
      :visibility=>10000,
      :wind_speed=>4.36,
      :wind_deg=>144,
      :weather=>
        [{:id=>804,
          :main=>"Clouds",
          :description=>"overcast clouds",
          :icon=>"04n"}],
      :pop=>0}

    weather = HourWeather.new(data)

    expect(weather.time).to eq('01:00:00')
    expect(weather.temperature).to eq(36.1)
    expect(weather.wind_speed).to eq('4 mph')
    expect(weather.wind_direction).to eq('from SE')
    expect(weather.conditions).to eq('overcast clouds')
    expect(weather.icon).to eq('04n')
  end
end
