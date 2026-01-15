require 'rails_helper'

RSpec.describe LocationWrapper do
  describe ".is_ip?" do
    instance = LocationWrapper.new("input")
    it "returns true if string is an ip address" do
      result = instance.is_ip?("8.8.8.8")
      expect(result).to be(true)
    end

    it "returns false if string is not an ip address" do
      result = instance.is_ip?("address")
      expect(result).to be(false)
    end
  end

  describe ".call" do
    it "if ip, returns valid hash with longitude and latiude data" do     
      instance = LocationWrapper.new({ 'input' => "8.8.8.8" })
      result = instance.call
      expect(result).to be_a(Hash)
      expect(result.size).to eq(3)
    end

    it "if invalid ip, returns valid has with error and reason" do
      instance = LocationWrapper.new({ 'input' => "192.168.1.100" })
      result = instance.call
      expect(result).to be_a(Hash)
      expect(result.size).to eq(2)
      expect(result["error"]).to be(true)      
    end

    it "if address, returns valid hash with longitude and latidue data" do
      instance = LocationWrapper.new({ 'input' => "Durham" })
      result = instance.call
      expect(result).to be_a(Hash)
      expect(result.size).to eq(3)
    end

    it "if invalid address, returns valid hash with error and reason" do
      instance = LocationWrapper.new({ 'input' => "4526 Holloman rd" })
      result = instance.call
      expect(result).to be_a(Hash)
      expect(result.size).to eq(2)
      expect(result["error"]).to be(true)
    end
  end
end
