

class WeatherApi
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def call
    gather_weather_data
  end

  def gather_weather_data
    response = HTTParty.get("https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_probability_max,wind_speed_10m_max,wind_gusts_10m_max,weather_code&hourly=temperature_2m,weather_code&models=best_match&current=temperature_2m,apparent_temperature,is_day,wind_speed_10m,weather_code&timezone=auto&timeformat=unixtime&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch")
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

# ^ Current conditions:
# locaiton name
# lat / long
# current temp (with low and high)
# feels like temp
# weather condition icon (snow, rain, sun, clouds, etc...)
# wind speed (direction?)
# sunrise
# sunset
# change of parcipipation
# ^ 7 Day
# Day name (shorthand)
# date? (Month shorthand and 7)
# weather icon (snow, rain, sun, clouds, etc...)
# high
# low
# chance or participation
# # ^ Hourly
# time
# temperature
# icon (snow, rain, sun, clouds, etc...)
# 
# & Icon list
# moon
# sun
# clouds
# run with cloud
# clouds with rain
# clouds with snow
# wind?

# https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{long}&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_probability_max,wind_speed_10m_max,wind_gusts_10m_max,weather_code&hourly=temperature_2m,weather_code&models=best_match&current=temperature_2m,apparent_temperature,is_day,wind_speed_10m,weather_code&timezone=auto&timeformat=unixtime&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch

# https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.419&daily=temperature_2m_max,temperature_2m_min