import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  connect() {
    console.log("🔥 sidebar controller connected")
  }

  async select(e) {
    console.log("clicked")

    const locationID = e.currentTarget.id
    try {
      const response = await fetch('sidebar/get_weather_data', {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify(locationID)
    });
    const result = await response.json()
    console.log(result.data.daily);

    document.querySelector(".main-content").innerHTML = `
      <div class="weather-container">
        <p>High: ${result.data.daily.temperature_2m_max[0]}</p>
        <p>Low: ${result.data.daily.temperature_2m_min[0]}</p>
      <div>
    `

    } catch (error) {
      console.log(error)
      //! render to user...
    }
    //! error handling, add try/catch
  }
}
