import { Controller } from "@hotwired/stimulus"

const COUNTRIES = "fr"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    alerts: Array
  }
  static targets = ["map"]

  connect() {
    console.log("Maps controller connected.")

    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.addMarkersToMap()
    this.fitMapToMarkers()
    this.geocoderSearch()
  }

  addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({color: "#FF4A4A"})
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  geocoderSearch() {
    const geocoder = new MapboxGeocoder({ 
      accessToken: mapboxgl.accessToken,
      countries: COUNTRIES,
      mapboxgl: mapboxgl 
    })
    
    const geocoderObj = document.getElementById("geocoder")
    geocoder.options.placeholder = "Enter your address"

    if (!document.querySelector('mapboxgl-ctrl-geocoder')) {
      geocoderObj.appendChild(geocoder.onAdd(this.map))
    }

    geocoder.on("result", (event) => {
      sessionStorage.setItem("addressEvent", event.result.place_name)

      const searchResult = event.result.geometry
      const options = { units: "kilometers" }
      const alerts = this.alertsValue

      alerts.forEach((alert) => {
        const alertPoint = new mapboxgl.Point(alert.longitude, alert.latitude)
        alert.distance = turf.distance(
          searchResult,
          turf.point([alert.longitude, alert.latitude]),
          options
        )
      })

      const alertsInProximity = alerts.filter(alert => Math.round(alert.distance * 100) / 100 <= 2)
      alertsInProximity.sort((a, b) => a.distance - b.distance)

      const recentAlertsContainer = document.querySelector('.recent-alerts');
      
      recentAlertsContainer.innerHTML = ""
      this.buildAlertList(alertsInProximity)
      this.fitMapToAlerts(alertsInProximity, searchResult)
    })
  }

  buildAlertList(alerts) {
    const recentAlerts = document.querySelector('.recent-alerts')
    document.getElementById('alerts-heading').innerText = "Alerts in this area"
    
  
    alerts.forEach((alert) => {
      recentAlerts.appendChild(this.renderAlert(alert))
    })
  }

  renderAlert(alert) {
    const alertUrl = document.getElementById('alert-path')
    const roundedDistance = Math.round(alert.distance * 100) / 100;

    const listingTemplate = document.getElementById("listingTemplate")
    console.log("listing temp", listingTemplate)
    const clone = listingTemplate.content.cloneNode(true)
    clone.id = `listing-${alert.id}`
    clone.querySelector("img").src = alert.photos[0].url
    clone.querySelector("a").href = alertUrl.value + "/" + alert.id
    clone.querySelector("a").textContent = alert.address
    console.log("title", clone.querySelector("span.title").textContent)
    clone.querySelector("span.title").textContent = alert.title
    clone.querySelector("p.description").textContent = alert.description
    clone.querySelector("span.distance").textContent = roundedDistance + " kms away"

    return clone
  }

  fitMapToAlerts(alerts, searchResult) {
    const result = { latitude: searchResult.coordinates[1], longitude: searchResult.coordinates[0]}
    alerts.push(result)
    const bounds = new mapboxgl.LngLatBounds()
    alerts.forEach(alert => bounds.extend([alert.longitude, alert.latitude]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 700 })
  }
}
