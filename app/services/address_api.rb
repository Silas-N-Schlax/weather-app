class AddressApi
  def initialize(input)
    @address = input
  end

  def call
    geo_api = ENV["GEO_API_KEY"]
    response = HTTParty.get("https://geocode.xyz/?locate=#{@address}}&geoit=json&auth=#{geo_api}")
    stringified_json = JSON.parse(response.body)
    if stringified_json["error"]
    puts stringified_json["error"]["description"]
      {
      "error" => true,
      "reason" => stringified_json["error"]["description"]
      }
    else
      {
        "error" => false,
        "lat" => stringified_json["latt"],
        "long" => stringified_json["longt"]
      }
    end
  end
end
