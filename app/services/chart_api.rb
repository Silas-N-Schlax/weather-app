
class ChartApi
  def initialize(data)
    p data
    @time_string = format_unixtime_to_day_and_stringify(data["time"])
    @temp_max = stringify_data(data["temperature_2m_max"])
    @temp_min = stringify_data(data["temperature_2m_min"])
    @max_temp = (data["temperature_2m_max"].compact.max / 10.0).ceil * 10 # What the max a min temp range is for the chart
    @min_temp = data["temperature_2m_min"].compact.min.floor(-1)
  end

  def call
    "https://image-charts.com/chart?cht=lc&chs=900x400&chco=58a6ff,f85149&chls=3|3&chdl=High Temp|Low Temp&chdls=c9d1d9,12&chtt=Highs and Lows Chart&chts=c9d1d9,20&chf=bg,s,21262d&chxt=x,y&chd=t:#{@temp_max}|#{@temp_min}&chxl=0:#{@time_string}&chxs=0,c9d1d9,14|1,c9d1d9&chxr=1,#{@min_temp},#{@max_temp}"
  end

  def format_unixtime_to_day_and_stringify(data)
    formated_stringified_data = ""
    for i in 0..data.length-1 do
      formated_stringified_data += "|#{Time.at(data[i]).strftime("%a")}"
    end
    formated_stringified_data
  end

  def stringify_data(data)
    stringified = ""
    for i in 0..data.length-1 do
      if i === 0
        stringified += "#{data[i]}"
      else
        stringified += ",#{data[i]}"
      end
    end
    stringified
  end
end

# https://image-charts.com/chart ?cht=<chart_type> &chd=<chart_data> &chs=<chart_size>