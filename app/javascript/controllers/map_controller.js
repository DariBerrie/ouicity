import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    alerts: Array
  }
  static targets = ["map"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    const geocoder = new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                          countries: 'fr',
                                          mapboxgl: mapboxgl })

    geocoder.options.placeholder = "Enter your address..."
    document.getElementById('geocoder').appendChild(geocoder.onAdd(this.map))

    geocoder.on('result', (event) => {
      // const searchResult = event.result.geometry
      // const options = { units: 'km' }
      // this.markersValue.forEach((marker) => {
      //   const markerPoint = new mapboxgl.Point(parseFloat(marker.lng), parseFloat(marker.lat))
      //   markerPoint.distance = turf.distance(
      //     searchResult,
      //     markerPoint.geometry,
      //     options
      //   )
      // })
      // const listings = document.getElementById('listings');
      // while (listings.firstChild) {
      //   listings.removeChild(listings.firstChild);
      // }
      this.#buildAlertList(this.alertsValue)
    })
  }
  
  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #buildAlertList() {
    this.alertsValue.forEach((alert) => {
      const listings = document.getElementById('listings')
      const listing = listings.appendChild(document.createElement('div'))
      listing.id = `listing-${alert.id}`
      listing.className = "item";

      listing.innerHTML = `
        <div class="listing card">
          <a href="#">${alert.address}</a>
          <strong>${alert.title}</strong>
          <p>${alert.description}</p>
          <img src = "https://www.thisiscolossal.com/wp-content/uploads/2016/07/graf-11.jpg" width="80" height="50">
        </div>`

      // const link = listing.appendChild(document.createElement('a'))
      // link.href = "#"
      // link.className = "title"
      // link.id = `link-${alert.id}`
      // link.innerHTML = `${alert.address}`

      // const details = listing.appendChild(document.createElement('div'))
      // details.innerHTML = (`<strong>${alert.title}</strong><br><p>${alert.description}</p>`)
      // const alert_coordinates = [alert.longitude, alert.latitude]
      // if (alert_coordinates.distance) {
      //   const roundedDistance = Math.round(alert_coordinates.distance * 100) / 100;
      //   details.innerHTML += `<div><strong>${roundedDistance} kms away</strong></div>`
      // }
    })
  }

}
