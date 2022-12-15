import { Controller } from "@hotwired/stimulus"
import * as bootstrap from 'bootstrap'

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    console.log("toast connected.")
    const toastTrigger = document.getElementById('liveToastBtn')
    const toastLiveExample = document.getElementById('liveToast')
    if (toastTrigger) {
      toastTrigger.addEventListener('click', () => {
        const toast = new bootstrap.Toast(toastLiveExample)

        toast.show()
      })
    }
  }
}
