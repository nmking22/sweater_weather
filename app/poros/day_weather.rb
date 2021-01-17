require_relative 'date_time_convertable'

class DayWeather
  include DateTimeConvertable

  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = convert_utc_date(data[:dt])
    @sunrise = convert_utc(data[:sunrise])
    @sunset = convert_utc(data[:sunset])
    @max_temp = data[:temp][:max].round(1)
    @min_temp = data[:temp][:min].round(1)
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def convert_utc_date(utc)
    DateTime.strptime(utc.to_s,'%s').strftime('%Y-%m-%d')
  end
end
