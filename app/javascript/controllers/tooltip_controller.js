import { Controller } from "@hotwired/stimulus"
import * as bootstrap from 'bootstrap'


// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = ["tooltip"]
  connect() {
    console.log("connected.")
    this.#setTooltip()
  }
  #setTooltip() {
    const categoryItems = document.querySelectorAll("div.category-item")
    categoryItems.forEach(item => {
      const category = item.querySelector(".form-check-input").value
      item.setAttribute('data-bs-toggle','tooltip')
      item.setAttribute('data-bs-placement','bottom')
      item.setAttribute('data-bs-title',this.#categoryDefinition(category))
    })
    var tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    var tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
  }

  // #insertCloseOnTooltip(){
  //   const tooltips = document.querySelectorAll("div.tooltip-inner")
  //   tooltips.forEach(tooltip => {
  //     tooltip.innerAdjacentHTML('afterbegin', '<i class="fa-solid fa-circle-xmark"></i>')
  //   })
  // }

  #categoryDefinition(value) {
    switch (value) {
      case "Vandalism" :
        return "Was a building recently tagged with graffiti? Has someone purposely destroyed public property? "+
        "If your alert addresses a similar concern, choose VANDALISM."
      case "Littering" :
        return "Choose LITTERING when you see trash in areas where it shouldn't be."
      case "Infrastructure" :
        return "The upkeep of our public properties is important. If you notice things that need repair "+
        " choose INFRASTRUCTURE."
      case "Transportation" :
        return "Is there anything happening on the road (besides traffic) that is making it harder or dangerous for you to get from "+
        "point A to point B? Choose TRANSPORTATION."
      case "New Idea" :
        return "Do you have a suggestion for improving the neighborhood? Let us know by choosing NEW IDEA."
      case "Other" :
        return "Your alert doesn't fit the above categories? No worries! Choose OTHER. "+
        "We will still review your submission."
    }
  }
}
