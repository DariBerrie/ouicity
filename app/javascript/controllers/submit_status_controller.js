import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-status"
export default class extends Controller {
  static targets = ["form", "status"]
  connect() {
    console.log("submit on status connected")
  }
  update(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.statusTarget.outerHTML = data
      })
  }
}
