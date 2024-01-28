import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="address-autocomplete"
const MAPBOX_TYPES = "country,region,place,postcode,locality,neighborhood,address"
const COUNTRIES = "fr"
export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["address"]

  connect() {
    console.log("Address Autocomplete controller connected.")
    const addressEvent = sessionStorage.getItem("addressEvent")
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: MAPBOX_TYPES,
      countries: COUNTRIES
    })

    this.geocoder.addTo(this.element)
    
    if (addressEvent) {
      this.geocoder.setInput(addressEvent)
    }

    this.geocoder.on("result", event => this.setInputValue(event))
    this.geocoder.on("clear", () => this.clearInputValue())
    this.geocoder.setPlaceholder("Enter an address...")
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  clearInputValue() {
    this.addressTarget.value = ""
  }
}
