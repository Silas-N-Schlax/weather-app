require 'rails_helper'

RSpec.describe IpApi do
  describe ".call" do
    it "returns latitude and longitude for a valid ip address with no error" do
      api = IpApi.new("8.8.8.8")
      result = api.call
      expect(result["error"]).to eq(false)
      expect(result["lat"]).to be_a(Float)
      expect(result["long"]).to be_a(Float)
    end

    it "returns error for invalid ip" do
      api = IpApi.new("Address")
      result = api.call
      expect(result["error"]).to eq(true)
    end
  end
end
