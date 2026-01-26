class SidebarController < ApplicationController
  def get_weather_data
    location_id = request.raw_post.split("_").last.to_i
    location = Location.find(location_id)

    weather_data = WeatherApi.new(location.lat, location.long)
    result = weather_data.call

    chart_data = ChartApi.new(result["data"]["daily"])
    chart_url = chart_data.call

    if result["error"]
      puts result["reason"]
      render json: {
        error: true,
        reason: result["reason"]
      }
      return
    end
    render json: {
      error: false,
      data: result["data"],
      chart: chart_url
    }
  end
end
