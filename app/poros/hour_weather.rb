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
