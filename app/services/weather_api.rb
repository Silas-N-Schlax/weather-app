

class WeatherApi
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def call
    gather_weather_data
  end

  def gather_weather_data
    response = HTTParty.get("https://api.open-meteo.com/v1/forecast?latitude=#{@lat}&longitude=#{@long}&daily=temperature_2m_max,temperature_2m_min")
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

# https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.419&daily=temperature_2m_max,temperature_2m_min