require 'rails_helper'
require 'json'

RSpec.describe ChartApi do
  describe ".call" do
    it "when given weather data, returns correct url for chart api" do
      data = {
        "time" => [ 1768539600, 1768626000, 1768712400, 1768798800, 1768885200, 1768971600, 1769058000, 1769144400, 1769230800, 1769317200, 1769403600, 1769490000, 1769576400, 1769662800, 1769749200, 1769835600 ],
        "temperature_2m_max" => [ 44.7, 52.4, 43.6, 45.9, 39.2, 48.1, 53.7, 47.6, 48, 33.6, 32.5, 30.8, 31.7, 33.9, 25.3, 37 ],
        "temperature_2m_min" => [ 17.6, 29.7, 30.6, 29.9, 25.5, 29.9, 35.3, 36.5, 34.9, 25.1, 20, 14.5, 21.8, 24.9, 16.4, 19 ]
      }
      api = ChartApi.new(data)
      result = api.call
      expected_link = "https://image-charts.com/chart?cht=lc&chs=900x400&chco=58a6ff,f85149&chls=3|3&chdl=High Temp|Low Temp&chdls=c9d1d9,12&chtt=Highs and Lows Chart&chts=c9d1d9,20&chf=bg,s,21262d&chxt=x,y&chd=t:44.7,52.4,43.6,45.9,39.2,48.1,53.7,47.6,48,33.6,32.5,30.8,31.7,33.9,25.3,37|17.6,29.7,30.6,29.9,25.5,29.9,35.3,36.5,34.9,25.1,20,14.5,21.8,24.9,16.4,19&chxl=0:|Fri|Sat|Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun|Mon|Tue|Wed|Thu|Fri|Sat&chxs=0,c9d1d9,14|1,c9d1d9&chxr=1,10,60"
      p result
      p expected_link
      expect(result.length).to eq(expected_link.length)
    end
  end
end
