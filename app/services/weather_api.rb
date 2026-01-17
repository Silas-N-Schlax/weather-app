

class WeatherApi
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def call
    gather_weather_data
  end

  def gather_weather_data
    response = HTTParty.get("https://api.open-meteo.com/v1/forecast?latitude=#{@lat}&longitude=#{@long}&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_probability_max,wind_speed_10m_max,wind_gusts_10m_max,weather_code&hourly=temperature_2m,weather_code&models=best_match&current=temperature_2m,apparent_temperature,is_day,wind_speed_10m,weather_code&timezone=auto&timeformat=unixtime&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch&forecast_days=16")
    stringified_json = JSON.parse(response.body)
    if stringified_json["error"]
      {
        "error" => true,
        "reason" => stringified_json["reason"]
      }
    else
      {
        "error" => false,
        "data" => stringified_json
      }
    end
  end
end
