import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];
  connect() {
    this.showAlert();
  }

  showAlert() {
    this.listTarget.classList.toggle("hidden");
  }
}
