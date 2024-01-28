import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    console.log("connected.")
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      countries: 'fr'
    })
    this.geocoder.addTo(this.element)
    if (sessionStorage.getItem("addressEvent")){
      this.geocoder.setInput(sessionStorage.getItem("addressEvent"))}
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
    this.geocoder.setPlaceholder("Enter an address...")
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
