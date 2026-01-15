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
        loadedContent.style.visibility = 'hidden';
        loadedContent.id = ""
        document.querySelector('.no-data').style.visibility = 'visible';
        document.querySelector('.loading').style.visibility = 'hidden';
      }
    }
  }
}