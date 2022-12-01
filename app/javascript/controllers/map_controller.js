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
    if (document.getElementById('geocoder')) {
      document.getElementById('geocoder').appendChild(geocoder.onAdd(this.map))
    }

    geocoder.on('result', (event) => {
      const searchResult = event.result.geometry
      const options = { units: 'kilometers' }
      const alerts = this.alertsValue
      alerts.forEach((alert) => {
        const alertPoint = new mapboxgl.Point(alert.longitude, alert.latitude)
        alert.distance = turf.distance(
          searchResult,
          turf.point([alert.longitude, alert.latitude]),
          options
        )
      })

      alerts.sort((a, b) => {
        if (a.distance > b.distance) {
          return 1;
        }
        if (a.distance < b.distance) {
          return -1;
        }
        return 0; // a must be equal to b
      })

      const nearbyAlerts = []
      alerts.forEach((alert) => {
        if ((Math.round(alert.distance * 100) / 100) <= 2){
          nearbyAlerts.push(alert)
        }
      })

      const listings = document.getElementById('listings');
      while (listings.firstChild) {
        listings.removeChild(listings.firstChild);
      }
      this.#buildAlertList(nearbyAlerts)
      this.#fitMapToAlerts(nearbyAlerts, searchResult)
    })
  }

  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({color: '#FF4A4A'})
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

  #fitMapToAlerts(alerts, searchResult) {
    const result = { latitude: searchResult.coordinates[1], longitude: searchResult.coordinates[0]}
    alerts.push(result)
    const bounds = new mapboxgl.LngLatBounds()
    alerts.forEach(alert => bounds.extend([alert.longitude, alert.latitude]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 700 })
  }

  #buildAlertList(alerts) {
    alerts.forEach((alert) => {
      const listings = document.getElementById('listings')
      const listing = listings.appendChild(document.createElement('div'))
      listing.id = `listing-${alert.id}`
      listing.className = "item";
      const roundedDistance = Math.round(alert.distance * 100) / 100;
      const alertsHeading = document.getElementById('alerts-heading')
      this.buildAlertsHeading()
      const alertUrl = document.getElementById('alert-path')
      listing.innerHTML = `
        <div class="listing card shadow-sm d-flex flex-row">
          <img class="me-3"
               src="${alert.photos[0].url}"
               style="width:80px; height:80px; border-radius:50%; object-fit:fill;">
          <div class="listing-details">
            <a href="${alertUrl.value}/${alert.id}">${alert.address}</a><br>
            <strong>${alert.title}</strong>
            <p class="fs-6">${alert.description}<br>
            <strong>${roundedDistance} kms away</strong></p>
          </div>
        </div>`
    })
  }
  buildAlertsHeading(){
    const alertsHeading = document.getElementById('alerts-heading')
    alertsHeading.innerHTML= `
      <h5 id="alerts-heading">Alerts in this area
      <a data-action="click->alerts#showAlertList"
      class="fs-3 toggle">
      <i class="fa-solid fa-circle-chevron-down"></i></a></h5>`
  }


}
