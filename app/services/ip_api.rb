class IpApi
  def initialize(input)
    @ip = input
  end

  def call
    response = HTTParty.get("https://ipapi.co/#{@ip}/json/")
    stringified_json = JSON.parse(response.body)
    if stringified_json["error"]
      {
        "error" => true,
        "reason" => stringified_json["reason"]
      }
    else
      {
        "error" => false,
        "lat" => stringified_json["latitude"],
        "long" => stringified_json["longitude"]
      }
    end
  end
end
