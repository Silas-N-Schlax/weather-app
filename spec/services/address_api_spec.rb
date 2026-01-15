require 'rails_helper'

RSpec.describe AddressApi do
  describe ".call" do
    it "returns latitude and longitude for a valid address with no errors" do
      api = AddressApi.new("Durham")
      result = api.call
      expect(result["error"]).to eq(false)
      expect(result["lat"]).to be_a(Float)
      expect(result["long"]).to be_a(Float)
    end

    it "returns error for invalid adress" do
      api = AddressApi.new("4526 Holloman Rd") # My home address is an invalid location 💀
      result = api.call
      expect(result["error"]).to eq(true)
    end
  end
end
