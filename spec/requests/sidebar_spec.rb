require 'rails_helper'

RSpec.describe "Sidebar", type: :request do
  describe "POST /get_weather_data" do
    let!(:location) { Location.create!({
      "name" => "Durham",
      "input" => "Durham",
      "lat" => "15".to_f,
      "long" => "5".to_f
      })
    }

    it "returns weather data on sucess" do
      allow_any_instance_of(WeatherApi).to receive(:call).and_return({
        "error" => false,
        "data" => {
          "daily" => {
            "temperature_2m_max" => [
              0, 0, 0, 0, 0, 0 # length 6
            ]
          }
        }
      })

      post "/sidebar/get_weather_data",
        params: location.id.to_json,
        headers: { 'CONTENT_TYPE' => "applicaiton/json" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["error"]).to be(false)
      expect(json["data"]["daily"]["temperature_2m_max"].size).to eq(6)
      expect(json["data"]).to be_a(Hash)
    end

    it "returns error when WeatherApi fails" do
      allow_any_instance_of(WeatherApi).to receive(:call).and_return({
        "error" => true,
        "reason" => "bad"
      })

      post "/sidebar/get_weather_data",
        params: location.id.to_json,
        headers: { 'CONTENT_TYPE' => "applicaiton/json" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["error"]).to be(true)
      expect(json["reason"]).to eq("bad")
    end
  end
end
