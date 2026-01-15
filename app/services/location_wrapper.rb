require "ipaddr"
require "json"

class LocationWrapper
  def initialize(data)
    @input = data["input"]
  end

  def call
    data = {}
    if is_ip?(@input)
      data = IpApi.new(@input).call
    else
      data = AddressApi.new(@input).call
    end
    data
  end

  def is_ip?(string)
    IPAddr.new(string)
    true
  rescue IPAddr::InvalidAddressError
    false
  end
end
