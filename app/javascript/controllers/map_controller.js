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
      const searchResult = event.result.geometry
      const options = { units: 'miles' }
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
    })


  }
  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({color: '#fd1f3d'})
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

  #buildAlertList(alerts) {
    alerts.forEach((alert) => {
      const listings = document.getElementById('listings')
      const listing = listings.appendChild(document.createElement('div'))
      listing.id = `listing-${alert.id}`
      listing.className = "item";
      const roundedDistance = Math.round(alert.distance * 100) / 100;
      listing.innerHTML = `
        <div class="listing card">
          <a href="#">${alert.address}</a>
          <strong>${alert.title}</strong>
          <p>${alert.description}</p>
          <img src = "https://www.thisiscolossal.com/wp-content/uploads/2016/07/graf-11.jpg" width="80" height="50">
          <strong>${roundedDistance} kms away</strong>
        </div>`

    })
  }

}
