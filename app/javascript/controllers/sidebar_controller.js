import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static values = {
    locationName: String
  }
  connect() { }
  
  async select(e) {
    const locationID = e.currentTarget.id
    const name = this.element.dataset.locationNameValue
    if (this.shouldLoadContent(locationID) === false) {
      return;
    }
    this.loadLoader()

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

    this.loadContent(result, locationID, name)

    } catch (error) {
      alert(`There has been an error, please try again later \nerr.msg: ${error}`)
    }
  }

  shouldLoadContent(id) {
    const current = document.querySelector(".weather-container")
    console.log(current.id)
    console.log("logging")
    if (current.id === id) {
      return false
    }
    return true
  }

  loadLoader() {
    document.querySelector('.loading').style.display = 'block';
    document.querySelector('.no-data').style.display = 'none';
    const loadedData = document.querySelector('.weather-container')
    loadedData.style.display = 'none';
    loadedData.innerHTML = ''
    loadedData.id = ''
  }

  loadContent(result, locationID, name) {
    const data = result.data
    const isDay = result.data.current.is_day === 0 ? false : true;
    console.log(result.data)
    console.log(this.codeReaderIcon("0", isDay))
    console.log(this.codeReaderText("0"))
    const weatherDiv = document.querySelector(".weather-container")
    if (!weatherDiv) return;
    weatherDiv.innerHTML = this.renderer(data.latitude, data.longitude, data.current, data.daily, name)
    weatherDiv.style.display = 'block';
    weatherDiv.id = locationID

    document.querySelector('.no-data').style.display = 'none';
    document.querySelector('.loading').style.display = 'none';
  }

  renderer(lat, long, current, daily, name) {
    console.log(daily.sunset[0])
    return `
      <div class="current">
        <div class="current-left">
          <div class="top">
            <div class="${this.codeReaderIcon(current.weather_code, current.is_day)}"></div>
            <div class="condition"> ${this.codeReaderText(current.weather_code)}</div>
          </div>
          <div class="temp">${current.temperature_2m}</div>
          <p class="feels">Feels like ${current.apparent_temperature}</p>
          <div class="high-low">
            <p>High: ${daily.temperature_2m_max[0]}</p>
            <p>◦</p>
            <p>Low: ${daily.temperature_2m_min[0]}</p>
          </div>
        </div>
        <div class="current-right">
          <div class="header">
            <div class="name">${name}</div>
            <div class="date">${new Date(current.time * 1000).toLocaleDateString()}</div>
          </div>
          <div class="rain">
            <div class="icon-cloud-rain"></div>
            <div>${daily.precipitation_probability_max[0]}%</div>
          </div>
          <div class="sunriseset">
            <div class="icon-sun"></div>
            <div>${new Date(daily.sunrise[0] * 1000).toLocaleTimeString()}</div>
            <div>◦</div>
            <div class="icon-moon"></div>
            <div>${new Date(daily.sunset[0] * 1000).toLocaleTimeString()}</div>
          </div>
          <hr style=" width: 80%; border-color: var(--cr-accent);">
          <div class="footer-card">
            <p>${lat}</p>
            <p>◦</p>
            <p>${long}</p>
          </div>
        </div>
      </div>
      <div class="daily">
        <div class="daily-content">
          <div class="top-daily">
            <div class="icon-calendar"></div>
            <div>16 Day Forcast</div>
          </div>
          <div class="cards-wrapper">
            <div class="cards">
              ${this.generateDailyCards(
                daily.time,
                daily.temperature_2m_max,
                daily.temperature_2m_min,
                daily.weather_code,
                current.is_day
              )}
            </div>
          </div>
        </div>
      </div>
    `
  }

  generateDailyCards(time, temp_max, temp_min, weather_code, isDay) {
    let html = ``;
    console.log("made it!")
    for (let i = 0; i < 15; i++) {
      html +=`
      <div id="${i}" class="card">
        <div class="max">${temp_max[i]}</div>
        <div class="min">${temp_min[i]}</div>
        <div class="${this.codeReaderIcon(weather_code[i], isDay)} icon"></div>
        <div>${new Date(time[i] * 1000).toLocaleDateString(undefined,
          {
            month: "short",
            day: "2-digit"
          }
        )}</div>
      </div>
      `
    }
    return html
  }


  codeReaderIcon(code, isDay) {
    const codeAndIconValuesDay = {
      0: "icon-sun",
      1: "icon-cloud-sun",
      2: "icon-cloud-sun",
      3: "icon-cloud-sun",
      45: "icon-cloudy",
      48: "icon-cloudy",
      51: "icon-cloud-drizzle",
      53: "icon-cloud-drizzle",
      55: "icon-cloud-drizzle",
      56: "icon-cloud-rain",
      57: "icon-cloud-rain",
      61: "icon-cloud-rain",
      63: "icon-cloud-rain",
      65: "icon-cloud-rain",
      66: "icon-cloud-rain",
      67: "icon-cloud-rain",
      71: "icon-cloud-snow",
      73: "icon-cloud-snow",
      75: "icon-cloud-snow",
      77: "icon-cloud-snow",
      80: "Heavy Rain",
      81: "Heavy Rain",
      83: "Heavy Rain",
      85: "icon-cloud-snow",
      86: "icon-cloud-snow",
      95: "Heavy Storm",
      96: "Heavy Storm",
      99: "Heavy Storm"
    }
    const codeAndIconValuesNight = {
      0: "icon-moon",
      1: "icon-cloud-moon",
      2: "icon-cloud-moon",
      3: "icon-cloud-moon"
    }
    code = parseInt(code)
    let match = "";
    if (code <= 3 && isDay === false) {
      match = codeAndIconValuesNight[code]
    } else {
      match = codeAndIconValuesDay[code]
    }
    return match
  }

  codeReaderText(code) {
    const codeAndIconValues = {
      0: "Clear",
      1: "Partially Cloudy",
      2: "Partially Cloudy",
      3: "Partially Cloudy",
      45: "Cloudy",
      48: "Cloudy",
      51: "Drizzle",
      53: "Drizzle",
      55: "Drizzle",
      56: "Raining",
      57: "Raining",
      61: "Raining",
      63: "Raining",
      65: "Raining",
      66: "Raining",
      67: "Raining",
      71: "icon-cloud-snow",
      73: "icon-cloud-snow",
      75: "icon-cloud-snow",
      77: "icon-cloud-snow",
      80: "Heavy Rain",
      81: "Heavy Rain",
      83: "Heavy Rain",
      85: "icon-cloud-snow",
      86: "icon-cloud-snow",
      95: "Heavy Storm",
      96: "Heavy Storm",
      99: "Heavy Storm"
    }
    return codeAndIconValues[parseInt(code)]
  }
}
