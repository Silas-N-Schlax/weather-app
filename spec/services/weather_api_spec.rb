require 'rails_helper'

RSpec.describe WeatherApi do
  describe ".call" do
    it "returns weather data with no errors" do
      api = WeatherApi.new("52.52".to_f, "13.419".to_f)
      result = api.call
      expect(result["error"]).to be(false)
      expect(result["data"]).to be_a(Hash)
      expect(result["data"].size).to_not eq(0)
    end

    it "returns error when API rejects request for any reason" do
      api = WeatherApi.new("50000".to_f, "13.419".to_f)
      result = api.call
      expect(result["error"]).to be(true)
    end
  end
end
