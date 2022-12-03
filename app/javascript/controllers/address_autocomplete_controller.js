import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    console.log("connected.")
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.setInput(sessionStorage.getItem("addressEvent"))
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
    this.geocoder.setPlaceholder("Enter an address...")
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #importInputValue() {
    if (sessionStorage.getItem("addressEvent")){
      const storedAddressInput = sessionStorage.getItem("addressEvent")
      this.addressTarget.value = storedAddressInput
    }
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
