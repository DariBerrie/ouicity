import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="change-status"
export default class extends Controller {
  static targets = ["status", "form"]

  connect() {
    console.log('Hello from the change status controller')
    console.log(this.element)
    console.log(this.itemsTarget)
    console.log(this.formTarget)
  }

  update() {
   /* fetch(this.formTarget.action,{
      method: “patch”,
      body: new FormData(this.formTarget)
    }) */
  }
}
