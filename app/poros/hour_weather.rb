require 'date'

class HourWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = convert_utc_time(data[:dt])
    @temperature = data[:temp].round(1)
    @wind_speed = "#{data[:wind_speed].round} mph"
    @wind_direction = convert_degrees(data[:wind_deg])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def convert_utc_time(utc)
    DateTime.strptime(utc.to_s,'%s').strftime('%I:%M:%S')
  end

  def convert_degrees(degrees)
    directions = ['N','NNE','NE','ENE','E','ESE', 'SE', 'SSE','S','SSW','SW','WSW','W','WNW','NW','NNW']
    direction_index = (degrees / 22.5).round
    "from #{directions[direction_index]}"
  end
end

# time, in a human-readable format such as “14:00:00”
# temperature, floating point number indicating the current temperature in Fahrenheit
# wind_speed, string, in miles per hour
# wind_direction, string, check wikipedia for how to convert this numeric value
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
