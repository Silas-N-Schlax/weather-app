class IpApi
  def initialize(input)
    @ip = input
  end

  def call
    error_codes = {
      400 => "The request sent to the API was bad, please try again!",
      404 => "The URL was Not Found, please try again or contact the developer for a fix!",
      403 => "The API could not verify our identity, authentication has failed, please try again!",
      405 => "The API received your request but has refused to respond please try again later!",
      429 => "The API has rate limited you, please try again later!"
    }
    response = HTTParty.get("https://ipapi.co/#{@ip}/json/")
    if response.code != 200
      return {
        "error" => true,
        "reason" => error_codes[response.code]
      }
    end
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
