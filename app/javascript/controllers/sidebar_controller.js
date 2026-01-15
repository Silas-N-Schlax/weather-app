import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  connect() { }

  loadLoader() {
    document.querySelector('.loading').style.visibility = 'visible';
    document.querySelector('.no-data').style.visibility = 'hidden';
    const loadedData = document.querySelector('.weather-container')
    loadedData.style.visibility = 'hidden';
    loadedData.innerHTML = ''
    loadedData.id = ''
  }

  loadContent(result, locationID) {
    const weatherDiv = document.querySelector(".weather-container")
    if (!weatherDiv) return;
    weatherDiv.innerHTML = `
      <p>High: ${result.data.daily.temperature_2m_max[0]}</p>
      <p>Low: ${result.data.daily.temperature_2m_min[0]}</p>
    `
    weatherDiv.style.visibility = 'visible';
    weatherDiv.id = locationID

    document.querySelector('.no-data').style.visibility = 'hidden';
    document.querySelector('.loading').style.visibility = 'hidden';
  }

  async select(e) {
    this.loadLoader()

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

    if (result.error) {
      alert(`There has been an error, please try again later \nerr.msg: ${result.reason}`)
    }

    this.loadContent(result, locationID)

    } catch (error) {
      alert(`There has been an error, please try again later \nerr.msg: ${error}`)
    }
  }
}
