import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-delete"
export default class extends Controller {
  connect() { }

  async delete(e) {
    e.stopPropagation()
    const locationID = e.currentTarget.id
    const loadedContent = document.querySelector(".weather-container")

    if (loadedContent.hasChildNodes()) {
      if (loadedContent.id === locationID) {
        loadedContent.innerHTML = ''
        loadedContent.style.display = 'none';
        loadedContent.id = ""
        document.querySelector('.no-data').style.display = 'block';
        document.querySelector('.loading').style.display = 'none';
      }
    }
  }
}