class WeatherAtEta
  attr_reader :temperature,
              :conditions

  def initialize(data, time)
    @temperature = find_temp(data, time)
    @conditions = find_conditions(data, time)
  end

  def find_temp(data, time)
    time_key = find_time_key(time)
    if time_key[0] == :hourly
      data[:hourly][time_key[1]][:temp].round(1).to_f
    else
      data[:daily][time_key[1]][:temp][:day].round(1).to_f
    end
  end

  def find_conditions(data, time)
    time_key = find_time_key(time)
    data[time_key[0]][time_key[1]][:weather][0][:description]
  end

  def find_time_key(time)
    hours = time / 3600
    return [:hourly, hours] if hours <= 48
    days = hours / 24
    return [:daily, days] if days <= 8
  end
end
