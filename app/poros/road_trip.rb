class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id

  def initialize(time, start_city, end_city, weather_at_eta)
    @id = 'null'
    @start_city = format_city(start_city)
    @end_city = format_city(end_city)
    @travel_time = convert_time(time)
    @weather_at_eta = weather_at_eta
  end

  def format_city(city)
    city_array = city.split(',')
    if city_array[0].include?(' ')
      city_name = city_array[0].split(' ')
      city_name.each do |city_word|
        city_word.capitalize!
      end
      city_array[0] = city_name.join(' ')
    else
      city_array[0].capitalize!
    end
    city_array[1].upcase!
    city_array.join(', ')
  end

  def convert_time(time)
    return time if time == 'impossible'
    if time < 60
      "#{time} second(s)"
    elsif (time / 60) < 60
      "#{time / 60} minute(s)"
    elsif (time / 3600) < 24
      "#{time / 3600} hour(s), #{time % 3600 / 60} minute(s)"
    else
      "#{time / 86400} day(s), #{time % 86400 / 3600} hour(s), #{time % 86400 % 3600 / 60} minute(s)"
    end
  end
end
