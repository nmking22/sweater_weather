require 'date'
require_relative 'date_time_convertable'

class CurrentWeather
  include DateTimeConvertable

  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = convert_utc(data[:dt])
    @sunrise = convert_utc(data[:sunrise])
    @sunset = convert_utc(data[:sunset])
    @temperature = data[:temp].round(1)
    @feels_like = data[:feels_like].round(1)
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end