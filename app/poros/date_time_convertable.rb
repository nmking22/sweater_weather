module DateTimeConvertable
  def convert_utc(utc)
    DateTime.strptime(utc.to_s,'%s').strftime('%Y-%m-%d %I:%M:%S %z')
  end
end
