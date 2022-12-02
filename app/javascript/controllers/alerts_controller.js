import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];
  connect() {

    this.showAlertList();
  }

  showAlertList(event) {
    this.listTarget.classList.toggle("hidden");
  }
}
