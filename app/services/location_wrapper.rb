require "ipaddr"
require "json"

class LocationWrapper
  def initialize(data)
    @input = data["input"]
  end

  def call
    data = {}
    if isIp?(@input)
      data = IpApi.new(@input).call
    else
      data = AddressApi.new(@input).call
    end
    data
  end

  def isIp?(string)
    IPAddr.new(string)
    true
  rescue IPAddr::InvalidAddressError
    false
  end
end
